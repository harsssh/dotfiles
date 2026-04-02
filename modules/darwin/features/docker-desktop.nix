import ../../../lib/mkFeature.nix "docker-desktop" {
  description = "Docker Desktop";
  enabledConfig = _: {
    homebrew.brews = [ "docker" ];
    homebrew.casks = [ "docker-desktop" ];
  };
}
