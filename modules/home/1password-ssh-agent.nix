{ lib, config, ... }:
{
  options.onePasswordSshAgent.entries = lib.mkOption {
    type = lib.types.listOf (lib.types.attrsOf lib.types.str);
    default = [];
  };

  config = {
    onePasswordSshAgent.entries = lib.mkBefore [{ vault = "Personal"; }];

    home.sessionVariables = {
      SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };

    xdg.configFile."1Password/ssh/agent.toml".text =
      let
        formatEntry = entry:
          "[[ssh-keys]]\n" +
          ''vault = "${entry.vault}"'' +
          (if entry ? item then "\nitem = \"${entry.item}\"" else "");
      in
      lib.concatStringsSep "\n\n" (map formatEntry config.onePasswordSshAgent.entries) + "\n";
  };
}
