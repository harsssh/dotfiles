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
      linuxProfiles = lib.filterAttrs (_: p: lib.hasSuffix "linux" p.system) profiles;
      publicFeatureModules = import ./modules/features.nix;

      mkDarwinConfig = privateModules: profileName: profile:
        let
          allModules = publicFeatureModules // privateModules;
          resolved = featuresLib.resolve allModules (profile.features or [ ]);
        in
        nix-darwin.lib.darwinSystem {
          inherit (profile) system;
          specialArgs = {
            inherit inputs profile profileName;
            privateHomeModules = resolved.homeModules;
          };
          modules = [
            home-manager.darwinModules.home-manager
            ./modules/darwin
            ./modules/darwin/homebrew.nix
          ] ++ resolved.darwinModules;
        };

      mkHomeManagerConfig = privateModules: profileName: profile:
        let
          inherit (profile) username system;
          allModules = publicFeatureModules // privateModules;
          resolved = featuresLib.resolve allModules (profile.features or [ ]);
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.${system};
          extraSpecialArgs = { inherit inputs profile; };
          modules = [
            {
              home.username = username;
              home.homeDirectory = "/home/${username}";
            }
            ./modules/home
          ] ++ resolved.homeModules ++ resolved.linuxModules;
        };

      mkDarwinConfigurations = privateModules:
        lib.mapAttrs (mkDarwinConfig privateModules) darwinProfiles;

      mkHomeManagerConfigurations = privateModules:
        lib.mapAttrs (mkHomeManagerConfig privateModules) linuxProfiles;
    in
    {
      darwinConfigurations = mkDarwinConfigurations { };
      homeConfigurations = mkHomeManagerConfigurations { };

      lib = {
        inherit mkDarwinConfig mkDarwinConfigurations;
        inherit mkHomeManagerConfig mkHomeManagerConfigurations;
      };
    };
}
