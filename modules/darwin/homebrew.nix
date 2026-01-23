{ pkgs, profileName, ... }:
let
  brewPrefix =
    if pkgs.stdenv.hostPlatform.isAarch64 then "/opt/homebrew" else "/usr/local";
  commonCasks = [
    "1password"
    "1password-cli"
    "arc"
    "alacritty"
    "docker-desktop"
    "gcloud-cli"
    "google-japanese-ime"
    "jetbrains-toolbox"
    "karabiner-elements"
    "visual-studio-code"
  ];
  additionalCasks = {
    personal = [ "orbstack" ];
  };
in
{
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      extraFlags = [ "--quiet" ];
    };
    brews = [
      "awscli"
      "bazelisk"
      "docker"
      "mise"
      "mycli"
      "ni"
      "terraform"
      "uv"
    ];
    casks = commonCasks ++ (additionalCasks.${profileName} or [ ]);
  };

  environment.interactiveShellInit = ''
    eval "$(${brewPrefix}/bin/brew shellenv)"
  '';
}
