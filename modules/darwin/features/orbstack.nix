import ../../../lib/mkFeature.nix "orbstack" {
  description = "OrbStack";
  enabledConfig = _: {
    homebrew.casks = [ "orbstack" ];
  };
}
