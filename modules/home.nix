{ pkgs, alacritty-theme, ... }:
{
  imports = [
    ./shell.nix
    ./zsh.nix
  ];

  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    neovim
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

    # JavaScript/Node
    bun
    pnpm

    # LLVM
    llvmPackages.clang
  ];
  programs.home-manager.enable = true;

  # alacritty
  xdg.configFile."alacritty/alacritty.toml".source = ../config/alacritty/alacritty.toml;
  xdg.configFile."alacritty/themes".source = "${alacritty-theme}/themes";

  # starship
  programs.starship.enable = true;
  xdg.configFile."starship.toml".source = ../config/starship/starship.toml;

  # fzf
  programs.fzf.enable = true;

  # tmux
  programs.tmux.enable = true;
}
