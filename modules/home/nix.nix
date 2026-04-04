{ lib, pkgs, config, ... }:
let
  nixCustomConf = pkgs.writeText "nix-custom.conf" (import ../nix-custom-conf.nix config.home.username);
in
{
  home.activation.installNixCustomConf = lib.mkIf pkgs.stdenv.isLinux (
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if ! diff -q ${nixCustomConf} /etc/nix/nix.custom.conf > /dev/null 2>&1; then
        $DRY_RUN_CMD /usr/bin/sudo install -m 644 ${nixCustomConf} /etc/nix/nix.custom.conf
        $DRY_RUN_CMD /usr/bin/sudo systemctl restart nix-daemon
      fi
    ''
  );
}
