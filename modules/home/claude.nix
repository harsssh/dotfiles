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
    # GitHub MCP から issue や PR にコメント・レビューを投稿させない
    permissions.deny = [
      "mcp__github__add_issue_comment"
      "mcp__github__add_comment_to_pending_review"
      "mcp__github__pull_request_review_write"
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
