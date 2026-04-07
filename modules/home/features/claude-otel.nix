import ../../../lib/mkFeature.nix "claude-otel" {
  description = "Claude OTEL headers";
  enabledConfig = _: {
    claude.otelHeadersHelper = "gcloud auth print-identity-token | xargs -I{} echo '{\"Authorization\": \"Bearer {}\"}'";
  };
}
