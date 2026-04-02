{ inputs }:
let
  lib = inputs.nixpkgs.lib;
  inherit (inputs) nix-darwin home-manager;
  defaultProfiles = import ../profiles.nix;

  mkDarwinConfiguration =
    { homeModules, darwinModules }:
    _name: profile:
    let
      inherit (profile) username;
    in
    nix-darwin.lib.darwinSystem {
      inherit (profile) system;
      specialArgs = { inherit inputs; };
      modules = [
        home-manager.darwinModules.home-manager
        ../modules/darwin
        { dotfiles.username = username; }
        {
          home-manager.users.${username}.imports =
            [ ../modules/home (profile.home or { }) ] ++ homeModules;
        }
        (profile.darwin or { })
      ] ++ darwinModules;
    };

  mkHomeConfiguration =
    { homeModules }:
    _name: profile:
    let
      inherit (profile) username;
    in
    home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${profile.system};
      extraSpecialArgs = { inherit inputs; };
      modules = [
        {
          home.username = username;
          home.homeDirectory = "/home/${username}";
        }
        ../modules/home
        (profile.home or { })
      ] ++ homeModules;
    };
in
{
  homeModules ? [ ],
  darwinModules ? [ ],
  profiles ? { },
}:
let
  allProfiles = defaultProfiles // profiles;
  isDarwin = _: p: lib.hasSuffix "darwin" p.system;
  isLinux = _: p: lib.hasSuffix "linux" p.system;
in
{
  darwinConfigurations = lib.mapAttrs
    (mkDarwinConfiguration { inherit homeModules darwinModules; })
    (lib.filterAttrs isDarwin allProfiles);

  homeConfigurations = lib.mapAttrs
    (mkHomeConfiguration { inherit homeModules; })
    (lib.filterAttrs isLinux allProfiles);
}
