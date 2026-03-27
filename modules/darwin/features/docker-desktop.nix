{ lib, config, ... }:
let
  cfg = config.features.docker-desktop;
in
{
  options.features.docker-desktop.enable = lib.mkEnableOption "Docker Desktop";

  config = lib.mkMerge [
    {
      features.docker-desktop.enable = lib.mkDefault (builtins.elem "docker-desktop" config.enabledFeatures);
    }
    (lib.mkIf cfg.enable {
      homebrew.brews = [ "docker" ];
      homebrew.casks = [ "docker-desktop" ];
    })
  ];
}
