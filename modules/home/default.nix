{ pkgs, inputs, ... }:
{
  imports = [
    ./alacritty.nix
    ./editorconfig.nix
    ./git.nix
    ./neovim
    ./nix.nix
    ./claude.nix
    ./shell.nix
    ./ssh.nix
    ./tmux.nix
    ./zsh.nix
    ./features/1password.nix
  ];

  programs.bash.enable = true;

  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.monaspace

    # CLI tools
    awscli2
    (google-cloud-sdk.withExtraComponents [
      google-cloud-sdk.components.gke-gcloud-auth-plugin
      google-cloud-sdk.components.kubectl
    ])
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
    k9s
    mycli
    tenv
    tflint
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
    go
    nodejs
    ruby
    llvmPackages.clang
    nixfmt
    pnpm
  ];
  programs.home-manager.enable = true;

  # mycli
  home.file.".myclirc".source = ../../config/.myclirc;

  # ideavim
  home.file.".ideavimrc".source = ../../config/.ideavimrc;

  # starship
  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    settings = {
      format = "$all\n$character";
      command_timeout = 1000;

      line_break = {
        # format で明示的に改行をいれてるので、disabled にする
        disabled = true;
      };

      character = {
        success_symbol = "[\\$](bold green)";
        error_symbol = "[\\$](bold red)";
        # zsh ではこれだけしか使えない
        vimcmd_symbol = "[V](bold green)";
      };

      aws.disabled = true;
      gcloud.disabled = true;
      package.disabled = true;
      username.disabled = true;
      time.disabled = true;
      jobs.disabled = false;
    };
  };

  # fzf
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    tmux.enableShellIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    defaultOptions = [ "--height=40%" "--layout=reverse" "--border" ];
  };

  # direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config.global.hide_env_diff = true;
  };
}
