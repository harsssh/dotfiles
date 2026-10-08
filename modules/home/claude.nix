{ config, lib, pkgs, ... }:
let
  # settings.json は Claude Code 自身が model・theme・autoMode 等の実行時状態を書き込む先なので、
  # ファイルごと Nix で配置すると CLI の書き込みと衝突する。ファイルは CLI に所有させ、
  # CLI の UI から変更しない値だけを activation でマージする。
  # マージは jq の * によるもので配列は置き換わるため、ここで宣言した配列は Nix が所有する。
  managedSettings = {
    statusLine = {
      type = "command";
      command = "~/.claude/statusline.sh";
    };
    hooks.Stop = [
      {
        hooks = [
          {
            type = "command";
            command = "~/.claude/hooks/notify.sh";
          }
        ];
      }
    ];
    autoCompactEnabled = false;
    permissions.deny = [
      # 取り消せない、または影響の大きい GitHub の操作をさせない
      "mcp__github__delete_repository"
      "mcp__github__merge_pull_request"
      "mcp__github__delete_file"
      # 利用者の名前で、他人に見えるコメント・レビューの投稿や Copilot の起動をさせない
      "mcp__github__add_issue_comment"
      "mcp__github__add_comment_to_pending_review"
      "mcp__github__pull_request_review_write"
      "mcp__github__add_reply_to_pull_request_comment"
      "mcp__github__update_issue_comment"
      "mcp__github__request_copilot_review"
      "mcp__github__assign_copilot_to_issue"
      "mcp__github__create_pull_request_with_copilot"
    ];
  };
  managedSettingsFile = (pkgs.formats.json { }).generate "claude-managed-settings.json" managedSettings;
in
{
  home.file.".claude/CLAUDE.md".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/claude/CLAUDE.md";
  home.file.".claude/statusline.sh" = {
    source = ../../config/claude/statusline.sh;
    executable = true;
  };
  home.file.".claude/hooks/notify.sh" = {
    source = ../../config/claude/hooks/notify.sh;
    executable = true;
  };
  home.file.".claude/skills".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/claude/skills";

  home.activation.mergeClaudeSettings = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    settings="${config.home.homeDirectory}/.claude/settings.json"
    if [ -e "$settings" ]; then src="$settings"; else src=/dev/null; fi
    tmp=$(mktemp "$settings.XXXXXX")
    # 壊れた JSON を上書きすると CLI が書いた設定を失うので、マージできなければ何もしない
    if ${lib.getExe pkgs.jq} -n --slurpfile managed ${managedSettingsFile} \
        '(first(inputs) // {}) * $managed[0]' "$src" > "$tmp"; then
      if ! cmp -s "$tmp" "$settings"; then
        run mv "$tmp" "$settings"
      fi
    else
      warnEcho "$settings is not valid JSON; skipped merging Nix-managed Claude Code settings"
    fi
    rm -f "$tmp"
  '';
}
