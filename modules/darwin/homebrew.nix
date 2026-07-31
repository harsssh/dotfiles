{ config, ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      # "zap" だと nix-darwin が付与する --force-cleanup を現行の brew が受け付けず
      # activation が失敗するため、直るまで "check" にしておく
      # https://github.com/nix-darwin/nix-darwin/issues/1807
      cleanup = "check";
      extraFlags = [ "--quiet" ];
    };
    brews = [
      "ni"
      "render"
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
      "Okta Verify" = 490179405;
      Kindle = 302584613;
    };
  };

  environment.systemPath = [ "${config.homebrew.prefix}/bin" ];
}
