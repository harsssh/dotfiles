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
      font-family = "Moralerspace Argon";
      font-size = 14;
      cursor-style = "block";
      cursor-style-blink = false;
      # shell integration はプロンプトでカーソルを bar に変えるため、cursor-style が上書きされる
      shell-integration-features = "no-cursor";
      macos-option-as-alt = true;
    };
  };
}
