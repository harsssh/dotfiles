{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    brews = [
      "awscli"
      "bazelisk"
      "coreutils"
      "difftastic"
      "docker"
      "fd"
      "findutils"
      "fzf"
      "gh"
      "ghq"
      "gnu-sed"
      "jq"
      "mise"
      "mycli"
      "neovim"
      "ni"
      "pstree"
      "ripgrep"
      "starship"
      "stow"
      "terraform"
      "tldr"
      "tmux"
      "tree"
      "uv"
      "watch"
      "wget"
    ];
    casks = [
      "1password-cli"
      "alacritty"
      "docker-desktop"
      "google-cloud-sdk"
      "visual-studio-code"
    ];
  };
}
