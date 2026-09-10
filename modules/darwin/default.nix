{ config, ... }:
let
  username = config.system.primaryUser;
in
{
  imports = [
    ./homebrew.nix
    ./system.nix
  ];

  system.stateVersion = 5;
  users.users.${username}.home = "/Users/${username}";
  nix.enable = false;
  security.pam.services.sudo_local.touchIdAuth = true;

  environment.etc."nix/nix.custom.conf".text = import ../nix-custom-conf.nix username;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  # ホスト側が home-manager.users を定義しなくても primary user に共通設定が適用されるようにする
  home-manager.users.${username} = { };
}
