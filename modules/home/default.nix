{ pkgs, alacritty-theme, ... }:
{
  imports = [
    ./git.nix
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

    # Go
    gopls

    # Vim
    vim
  ];
  programs.home-manager.enable = true;

  # alacritty
  xdg.configFile."alacritty/alacritty.toml".source = ../../config/alacritty/alacritty.toml;
  xdg.configFile."alacritty/themes".source = "${alacritty-theme}/themes";

  # claude
  home.file.".claude/settings.json".source = ../../config/claude/settings.json;
  home.file.".claude/CLAUDE.md".source = ../../config/claude/CLAUDE.md;

  # mise
  xdg.configFile."mise/config.toml".source = ../../config/mise/config.toml;

  # mycli
  home.file.".myclirc".source = ../../config/mycli/.myclirc;

  # vim
  home.file.".vimrc".source = ../../config/vim/.vimrc;

  # starship
  programs.starship.enable = true;
  xdg.configFile."starship.toml".source = ../../config/starship/starship.toml;

  # fzf
  programs.fzf.enable = true;

  # tmux
  programs.tmux.enable = true;
}
