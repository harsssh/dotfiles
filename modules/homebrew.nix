{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    brews = [
      "awscli"
      "bazelisk"
      "docker"
      "mise"
      "mycli"
      "neovim"
      "ni"
      "terraform"
      "uv"
    ];
    casks = [
      "1password-cli"
      "alacritty"
      "docker-desktop"
      "gcloud-cli"
      "visual-studio-code"
    ];
  };
}
