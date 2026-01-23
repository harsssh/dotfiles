{ pkgs, profile, ... }:
let
  brewPrefix =
    if pkgs.stdenv.hostPlatform.isAarch64 then "/opt/homebrew" else "/usr/local";
  commonCasks = [
    "1password-cli"
    "alacritty"
    "docker-desktop"
    "gcloud-cli"
    "visual-studio-code"
  ];
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
    casks = commonCasks ++ profile.casks;
  };

  environment.interactiveShellInit = ''
    eval "$(${brewPrefix}/bin/brew shellenv)"
  '';
}
