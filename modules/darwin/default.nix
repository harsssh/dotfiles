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
