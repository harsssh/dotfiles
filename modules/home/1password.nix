{ lib, pkgs, config, ... }:
let
  cfg = config.dotfiles.onePassword;
  inherit (pkgs.stdenv) isDarwin;

  sshSignProgram =
    if isDarwin
    then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
    else "/opt/1Password/op-ssh-sign";

  agentSock =
    if isDarwin
    then "Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else ".1password/agent.sock";

  sshKey = {
    options = {
      vault = lib.mkOption {
        type = lib.types.str;
        description = "Name of the vault that holds the key.";
      };
      item = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Name of the item. When null, every SSH key in the vault is used.";
      };
    };
  };

  formatSshKey = key:
    "[[ssh-keys]]\n"
    + ''vault = "${key.vault}"''
    + lib.optionalString (key.item != null) "\nitem = \"${key.item}\"";
in
{
  options.dotfiles.onePassword = {
    enable = lib.mkEnableOption "1Password SSH agent integration";

    sshKeys = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule sshKey);
      default = [ { vault = "Personal"; } ];
      description = "SSH keys the 1Password agent offers, in order. Written to agent.toml as ssh-keys entries.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables.SSH_AUTH_SOCK = "$HOME/${agentSock}";

    xdg.configFile."1Password/ssh/agent.toml".text =
      lib.concatStringsSep "\n\n" (map formatSshKey cfg.sshKeys) + "\n";

    programs.git.settings.gpg.ssh.program = sshSignProgram;

    programs.ssh.settings."*".IdentityAgent = "\"~/${agentSock}\"";
  };
}
