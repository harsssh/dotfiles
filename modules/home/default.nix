{ pkgs, inputs, ... }:
{
  imports = [
    ./editorconfig.nix
    ./git.nix
    ./neovim.nix
    ./shell.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.monaspace

    # CLI tools
    coreutils
    difftastic
    fd
    findutils
    gh
    ghq
    gnused
    httpie
    jq
    pstree
    ripgrep
    tldr
    tree
    watch
    wget

    # Languages
    bun
    llvmPackages.clang
    nixfmt
    pnpm

    # Editors
    vim
  ];
  programs.home-manager.enable = true;

  # alacritty
  xdg.configFile."alacritty/alacritty.toml".source = ../../config/alacritty.toml;
  xdg.configFile."alacritty/themes".source = "${inputs.alacritty-theme}/themes";

  # claude
  home.file.".claude/settings.json".source = ../../config/claude/settings.json;
  home.file.".claude/CLAUDE.md".source = ../../config/claude/CLAUDE.md;

  # mise
  xdg.configFile."mise/config.toml".source = ../../config/mise.toml;

  # mycli
  home.file.".myclirc".source = ../../config/.myclirc;

  # vim
  home.file.".vimrc".source = ../../config/vim/.vimrc;

  # ideavim
  home.file.".ideavimrc".source = ../../config/.ideavimrc;

  # starship
  programs.starship.enable = true;
  xdg.configFile."starship.toml".source = ../../config/starship.toml;

  # fzf
  programs.fzf.enable = true;

  # direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
