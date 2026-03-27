{ lib, config, ... }:
let
  cfg = config.features.orbstack;
in
{
  options.features.orbstack.enable = lib.mkEnableOption "OrbStack";

  config = lib.mkMerge [
    {
      features.orbstack.enable = lib.mkDefault (builtins.elem "orbstack" config.enabledFeatures);
    }
    (lib.mkIf cfg.enable {
      homebrew.casks = [ "orbstack" ];
    })
  ];
}
