{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    # nixpkgs の ghostty は Linux 向けのソースビルドのみで、macOS では配布バイナリを包んだ ghostty-bin を使う
    package = if pkgs.stdenv.hostPlatform.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    settings = {
      theme = "Miasma";
      background = "#000000";
      palette = [
        "1=#a65d57"
        "9=#c47a72"
      ];
      # 既定の 0.5 では Miasma の暗い色を faint にしたときに黒背景へ沈んで読めない
      faint-opacity = 0.75;
      font-family = "Moralerspace Argon";
      font-size = 15;
      cursor-style = "block";
      cursor-style-blink = false;
      # shell integration はプロンプトでカーソルを bar に変えるため、cursor-style が上書きされる
      # ssh 先に xterm-ghostty の terminfo がないと表示が崩れるため、terminfo の転送と TERM の差し替えを有効にする
      shell-integration-features = "no-cursor,ssh-terminfo,ssh-env";
      macos-option-as-alt = true;
      # タブと分割は tmux で行う
      macos-titlebar-style = "hidden";
      window-padding-x = 8;
      window-padding-y = 8;
      window-padding-balance = true;
      window-save-state = "always";
      mouse-hide-while-typing = true;
      # tmux や nvim から OSC 52 で読むたびに確認ダイアログが出るのを避ける
      clipboard-read = "allow";
      # Nix でバージョンを固定しているため、Ghostty 自身の更新は使わない
      auto-update = "off";
    };
  };
}
