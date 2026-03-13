{ config, lib, pkgs, ... }:
let
  cfg = config.claude;
  jsonFormat = pkgs.formats.json { };
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
    home.file.".claude/settings.json".source = jsonFormat.generate "settings.json" settings;
    home.file.".claude/CLAUDE.md".source = ../../config/claude/CLAUDE.md;
    home.file.".claude/statusline.sh" = {
      source = ../../config/claude/statusline.sh;
      executable = true;
    };
  };
}
