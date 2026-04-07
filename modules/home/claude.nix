{ config, lib, pkgs, ... }:
let
  cfg = config.claude;
  jsonFormat = pkgs.formats.json { };
  localSettings = lib.optionalAttrs (cfg.otelHeadersHelper != null) {
    inherit (cfg) otelHeadersHelper;
  };
in
{
  options.claude.otelHeadersHelper = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
  };

  config = {
    # settings.json は手動で権限を調整できるよう symlink で配置する。
    # 環境固有の設定 (otelHeadersHelper 等) は settings.local.json に分離して Nix で生成する。
    home.file.".claude/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/claude/settings.json";
    home.file.".claude/settings.local.json" = lib.mkIf (localSettings != { }) {
      source = jsonFormat.generate "settings.local.json" localSettings;
    };
    home.file.".claude/CLAUDE.md".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/claude/CLAUDE.md";
    home.file.".claude/statusline.sh" = {
      source = ../../config/claude/statusline.sh;
      executable = true;
    };
    home.file.".claude/skills".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/claude/skills";
  };
}
