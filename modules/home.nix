{ pkgs, ... }:
{
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    nixfmt

    # CLI tools
    coreutils
    difftastic
    fd
    findutils
    gh
    ghq
    gnused
    jq
    pstree
    ripgrep
    tldr
    tree
    watch
    wget
  ];
  programs.home-manager.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = false;
  };
  xdg.configFile."starship.toml".source = ../config/starship/starship.toml;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.tmux = {
    enable = true;
  };
}
