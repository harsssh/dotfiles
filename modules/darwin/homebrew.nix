{ config, ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      extraFlags = [ "--quiet" ];
    };
    brews = [
      "ni"
    ];
    casks = [
      "1password"
      "1password-cli"
      "arc"
      "google-japanese-ime"
      "jetbrains-toolbox"
      "karabiner-elements"
      "obsidian"
      "raycast"
      "slack"
      "tailscale-app"
      "visual-studio-code"
    ];
    masApps = {
      RunCat = 1429033973;
    };
  };

  environment.systemPath = [ config.homebrew.brewPrefix ];
}
