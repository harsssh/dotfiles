{ pkgs, ... }:
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
          IdentityAgent =
            if pkgs.stdenv.isDarwin
            then "\"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\""
            else "\"~/.1password/agent.sock\"";
        };
      };
    };
  };
}
