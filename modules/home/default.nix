{ pkgs, inputs, ... }:
{
  imports = [
    ./1password-ssh-agent.nix
    ./editorconfig.nix
    ./git.nix
    ./neovim.nix
    ./shell.nix
    ./ssh.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.monaspace

    # CLI tools
    awscli2
    ssm-session-manager-plugin
    bazelisk
    coreutils
    devenv
    difftastic
    fd
    findutils
    gh
    ghq
    gnused
    httpie
    jq
    mycli
    peco
    pstree
    ripgrep
    tldr
    tree
    uv
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
