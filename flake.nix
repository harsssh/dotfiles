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
      featuresLib = import ./lib/features.nix { inherit lib; };
      profiles = import ./profiles.nix;
      darwinProfiles = lib.filterAttrs (_: p: lib.hasSuffix "darwin" p.system) profiles;

      mkDarwinConfig = privateModules: profileName: profile:
        let
          resolved = featuresLib.resolve privateModules (profile.privateFeatures or [ ]);
        in
        nix-darwin.lib.darwinSystem {
          inherit (profile) system;
          specialArgs = {
            inherit inputs profile profileName;
            privateHomeModules = resolved.home;
          };
          modules = [
            home-manager.darwinModules.home-manager
            ./modules/darwin
            ./modules/darwin/homebrew.nix
          ] ++ resolved.darwin;
        };

      mkDarwinConfigurations = privateModules:
        lib.mapAttrs (mkDarwinConfig privateModules) darwinProfiles;
    in
    {
      darwinConfigurations = mkDarwinConfigurations { };

      lib = { inherit mkDarwinConfig mkDarwinConfigurations; };
    };
}
