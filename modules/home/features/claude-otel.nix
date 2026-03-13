{ ... }:
{
  claude.otelHeadersHelper = "gcloud auth print-identity-token | xargs -I{} echo '{\"Authorization\": \"Bearer {}\"}'";
}
