{ pkgs, ... }:
let
  opPaths = import ../../lib/1password.nix { inherit (pkgs.stdenv) isDarwin; };
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [ "~/.ssh/config.local" ];
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };
      "*" = {
        addKeysToAgent = "yes";
        forwardAgent = true;
        extraOptions = {
          IdentityAgent = "\"~/${opPaths.agentSockRelative}\"";
        };
      };
    };
  };
}
