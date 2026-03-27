{ lib, pkgs, config, ... }:
let
  cfg = config.features."1password";
  opPaths = import ../../../lib/1password.nix { inherit (pkgs.stdenv) isDarwin; };
in
{
  options.features."1password".enable = lib.mkEnableOption "1Password SSH agent integration";

  options.onePasswordSshAgent.entries = lib.mkOption {
    type = lib.types.listOf (lib.types.attrsOf lib.types.str);
    default = [ ];
  };

  config = lib.mkMerge [
    {
      features."1password".enable = lib.mkDefault (builtins.elem "1password" config.enabledFeatures);
    }
    (lib.mkIf cfg.enable {
      onePasswordSshAgent.entries = lib.mkBefore [{ vault = "Personal"; }];

      home.sessionVariables = {
        SSH_AUTH_SOCK = "$HOME/${opPaths.agentSockRelative}";
      };

      xdg.configFile."1Password/ssh/agent.toml".text =
        let
          formatEntry = entry:
            "[[ssh-keys]]\n"
            + ''vault = "${entry.vault}"''
            + (if entry ? item then "\nitem = \"${entry.item}\"" else "");
        in
        lib.concatStringsSep "\n\n" (map formatEntry config.onePasswordSshAgent.entries) + "\n";

      programs.git.settings.gpg.ssh.program = opPaths.sshSignProgram;

      programs.ssh.matchBlocks."*".extraOptions = {
        IdentityAgent = "\"~/${opPaths.agentSockRelative}\"";
      };
    })
  ];
}
