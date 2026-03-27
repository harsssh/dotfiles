{ lib, ... }:
{
  options.enabledFeatures = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "List of feature names to enable.";
  };
}
