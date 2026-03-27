{ isDarwin }:
{
  sshSignProgram =
    if isDarwin
    then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
    else "/opt/1Password/op-ssh-sign";

  agentSockRelative =
    if isDarwin
    then "Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else ".1password/agent.sock";
}
