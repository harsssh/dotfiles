{ pkgs, ... }:
let
  brewPrefix =
    if pkgs.stdenv.hostPlatform.isAarch64 then "/opt/homebrew" else "/usr/local";
in
{
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      extraFlags = [ "--quiet" ];
    };
    brews = [
      "ni"
      "terraform"
    ];
    casks = [
      "1password"
      "1password-cli"
      "arc"
      "alacritty"
      "gcloud-cli"
      "google-japanese-ime"
      "jetbrains-toolbox"
      "karabiner-elements"
      "raycast"
      "visual-studio-code"
    ];
    masApps = {
      RunCat = 1429033973;
    };
  };

  environment.interactiveShellInit = ''
    eval "$(${brewPrefix}/bin/brew shellenv)"
  '';
}
