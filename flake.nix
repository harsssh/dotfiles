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
      defaultProfiles = import ./profiles.nix;
      publicFeatureModules = import ./modules/features.nix;

      mkConfigurations = { modules ? {}, profiles ? {} }:
        let
          allModules = publicFeatureModules // modules;
          allProfiles = defaultProfiles // profiles;
          resolve = profile: featuresLib.resolve allModules (profile.features or [ ]);
        in
        {
          darwinConfigurations = lib.mapAttrs (name: profile:
            let resolved = resolve profile; in
            nix-darwin.lib.darwinSystem {
              inherit (profile) system;
              specialArgs = {
                inherit inputs profile;
                profileName = name;
                privateHomeModules = resolved.homeModules;
              };
              modules = [
                home-manager.darwinModules.home-manager
                ./modules/darwin
                ./modules/darwin/homebrew.nix
              ] ++ resolved.darwinModules;
            }
          ) (lib.filterAttrs (_: p: lib.hasSuffix "darwin" p.system) allProfiles);

          homeConfigurations = lib.mapAttrs (name: profile:
            let
              username = lib.elemAt (lib.splitString "@" name) 0;
              resolved = resolve profile;
            in
            home-manager.lib.homeManagerConfiguration {
              pkgs = inputs.nixpkgs.legacyPackages.${profile.system};
              extraSpecialArgs = { inherit inputs profile; };
              modules = [
                {
                  home.username = username;
                  home.homeDirectory = "/home/${username}";
                }
                ./modules/home
              ] ++ resolved.homeModules ++ resolved.linuxModules;
            }
          ) (lib.filterAttrs (_: p: lib.hasSuffix "linux" p.system) allProfiles);
        };

      defaultConfigs = mkConfigurations { };
    in
    {
      inherit (defaultConfigs) darwinConfigurations homeConfigurations;
      inherit mkConfigurations;
    };
}
