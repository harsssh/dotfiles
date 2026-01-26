{ lib, config, ... }:
{
  options.onePasswordSshAgent.entries = lib.mkOption {
    type = lib.types.listOf (lib.types.attrsOf lib.types.str);
    default = [{ vault = "Personal"; }];
  };

  config = {
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
