{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alacritty-theme = {
      url = "github:alacritty/alacritty-theme";
      flake = false;
    };
  };

  outputs =
    inputs@{ nix-darwin, home-manager, ... }:
    let
      lib = inputs.nixpkgs.lib;
      profiles = import ./profiles.nix;
      darwinProfiles = lib.filterAttrs (_: p: lib.hasSuffix "darwin" p.system) profiles;

      mkDarwinConfig = privateModules: profileName: profile:
        let
          resolved = map (f: privateModules.${f}) (profile.privateFeatures or [ ]);
          privateHomeModules = map (m: m.module) (lib.filter (m: m.type == "home") resolved);
          privateDarwinModules = map (m: m.module) (lib.filter (m: m.type == "darwin") resolved);
        in
        nix-darwin.lib.darwinSystem {
          inherit (profile) system;
          specialArgs = { inherit inputs profile profileName privateHomeModules; };
          modules = [
            home-manager.darwinModules.home-manager
            ./modules/darwin
            ./modules/darwin/homebrew.nix
          ] ++ privateDarwinModules;
        };

      mkDarwinConfigurations = privateModules:
        lib.mapAttrs (mkDarwinConfig privateModules) darwinProfiles;
    in
    {
      darwinConfigurations = mkDarwinConfigurations [ ];

      lib = { inherit mkDarwinConfig mkDarwinConfigurations; };
    };
}
