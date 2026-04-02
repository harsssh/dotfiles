name:
{
  description,
  extraOptions ? (_: { }),
  enabledConfig,
}:
{ lib, pkgs, config, ... }@args:
{
  options = { features.${name}.enable = lib.mkEnableOption description; } // (extraOptions args);

  config = lib.mkMerge [
    { features.${name}.enable = lib.mkDefault (builtins.elem name config.enabledFeatures); }
    (lib.mkIf config.features.${name}.enable (enabledConfig args))
  ];
}
