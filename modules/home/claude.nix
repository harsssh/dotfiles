{ config, lib, ... }:
let
  cfg = config.claude;
  baseSettings = builtins.fromJSON (builtins.readFile ../../config/claude/settings.json);
  settings =
    baseSettings
    // lib.optionalAttrs (cfg.otelHeadersHelper != null) {
      inherit (cfg) otelHeadersHelper;
    };
in
{
  options.claude.otelHeadersHelper = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
  };

  config = {
    home.file.".claude/settings.json".text = builtins.toJSON settings;
    home.file.".claude/CLAUDE.md".source = ../../config/claude/CLAUDE.md;
  };
}
