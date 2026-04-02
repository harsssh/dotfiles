name:
{
  description,
  extraOptions ? (_: { }),
  enabledConfig,
}:
{ lib, pkgs, config, ... }@args:
{
  options = { features.${name}.enable = lib.mkEnableOption description; } // (extraOptions args);

  config = lib.mkIf config.features.${name}.enable (enabledConfig args);
}
