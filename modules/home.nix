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

  # zsh
  home.file.".zshrc".source = ../config/zsh/zshrc;
  home.file.".zsh/core.zsh".source = ../config/zsh/core.zsh;
  home.file.".zsh/plugins.zsh".source = ../config/zsh/plugins.zsh;
  home.file.".zsh/user.zsh".source = ../config/zsh/user.zsh;

  # starship (initialized in core.zsh)
  programs.starship.enable = true;
  programs.starship.enableZshIntegration = false;
  xdg.configFile."starship.toml".source = ../config/starship/starship.toml;

  # fzf (initialized in core.zsh)
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = false;

  # tmux
  programs.tmux.enable = true;
}
