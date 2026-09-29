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
      font-family = "MonaspiceAr Nerd Font";
      font-size = 14;
      cursor-style-blink = false;
      macos-option-as-alt = true;
      keybind = [ "shift+enter=text:\\n" ];
    };
  };
}
