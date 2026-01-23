{ inputs, profile, ... }:
let
  inherit (profile) username homeDirectory;
in
{
  system.stateVersion = 5;
  system.primaryUser = username;
  users.users.${username}.home = homeDirectory;
  nix.enable = false;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs profile; };
  home-manager.users.${username} = {
    home.username = username;
    home.homeDirectory = homeDirectory;
    imports = [ ../home ];
  };
}
