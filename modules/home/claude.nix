{ config, ... }:
{
  # settings.json は Claude Code 自身が model・theme・autoMode 等の実行時状態を書き込む先なので、
  # Nix で配置すると CLI の書き込みと衝突する。宣言的に管理せず CLI に所有させる。
  home.file.".claude/CLAUDE.md".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/claude/CLAUDE.md";
  home.file.".claude/statusline.sh" = {
    source = ../../config/claude/statusline.sh;
    executable = true;
  };
  # Stop hook 本体。hook の登録先は settings.json しかなく、そのファイルは上記の理由で
  # Nix 管理外なので、スクリプトのみ配置し settings.json への登録は手動で行う。
  home.file.".claude/hooks/notify.sh" = {
    source = ../../config/claude/hooks/notify.sh;
    executable = true;
  };
  home.file.".claude/skills".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/claude/skills";
}
