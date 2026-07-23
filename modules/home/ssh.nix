{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [ "~/.ssh/config.local" ];
    settings = {
      "github.com" = {
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519";
        IdentitiesOnly = true;
      };
      "*" = {
        AddKeysToAgent = "yes";
        ForwardAgent = true;
      };
    };
  };
}
