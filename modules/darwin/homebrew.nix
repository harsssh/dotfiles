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
      "docker"
      "ni"
      "terraform"
    ];
    casks = [
      "1password"
      "1password-cli"
      "arc"
      "alacritty"
      "docker-desktop"
      "gcloud-cli"
      "google-japanese-ime"
      "jetbrains-toolbox"
      "karabiner-elements"
      "raycast"
      "visual-studio-code"
    ];
  };

  environment.interactiveShellInit = ''
    eval "$(${brewPrefix}/bin/brew shellenv)"
  '';
}
