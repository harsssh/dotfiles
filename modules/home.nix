{ pkgs, ... }:
{
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    nixfmt
  ];
  programs.home-manager.enable = true;

  xdg.configFile."starship.toml".source = ../config/starship/starship.toml;
}
