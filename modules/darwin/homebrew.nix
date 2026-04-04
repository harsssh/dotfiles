{ config, ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      extraFlags = [ "--quiet" ];
    };
    taps = [ "hashicorp/tap" ];
    brews = [
      "ni"
      { name = "hashicorp/tap/terraform"; link = true; }
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
      "tailscale-app"
      "visual-studio-code"
    ];
    masApps = {
      RunCat = 1429033973;
    };
  };

  environment.systemPath = [ config.homebrew.brewPrefix ];
}
