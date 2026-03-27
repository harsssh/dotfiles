{ lib, config, ... }:
let
  cfg = config.features.claude-otel;
in
{
  options.features.claude-otel.enable = lib.mkEnableOption "Claude OTEL headers";

  config = lib.mkMerge [
    {
      features.claude-otel.enable = lib.mkDefault (builtins.elem "claude-otel" config.enabledFeatures);
    }
    (lib.mkIf cfg.enable {
      claude.otelHeadersHelper = "gcloud auth print-identity-token | xargs -I{} echo '{\"Authorization\": \"Bearer {}\"}'";
    })
  ];
}
