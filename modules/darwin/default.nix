{ inputs, profile, profileName, privateHomeModules ? [ ], ... }:
let
  inherit (profile) username;
  homeDirectory = "/Users/${username}";
in
{
  imports = [ ./system.nix ];
  system.stateVersion = 5;
  system.primaryUser = username;
  users.users.${username}.home = homeDirectory;
  nix.enable = false;

  environment.etc."nix/nix.custom.conf".text = ''
    extra-substituters = https://nix-community.cachix.org
    extra-trusted-public-keys = nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
    http-connections = 50
    narinfo-cache-positive-ttl = 86400
  '';

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.extraSpecialArgs = { inherit inputs profile; };
  home-manager.users.${username} = {
    home.username = username;
    home.homeDirectory = homeDirectory;
    imports = [ ../home ] ++ privateHomeModules;
  };
}
