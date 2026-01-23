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
      "awscli"
      "bazelisk"
      "docker"
      "mise"
      "mycli"
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

  environment.interactiveShellInit = ''
    eval "$(${brewPrefix}/bin/brew shellenv)"
  '';
}
