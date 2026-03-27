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
      defaultProfiles = import ./profiles.nix;

      mkConfigurations =
        {
          homeModules ? [ ],
          darwinModules ? [ ],
          profiles ? { },
        }:
        let
          allProfiles = defaultProfiles // profiles;
          featuresConfig = profile: { enabledFeatures = profile.features or [ ]; };
        in
        {
          darwinConfigurations = lib.mapAttrs (
            name: profile:
            nix-darwin.lib.darwinSystem {
              inherit (profile) system;
              specialArgs = {
                inherit inputs profile;
                profileName = name;
                privateHomeModules = homeModules;
              };
              modules = [
                home-manager.darwinModules.home-manager
                ./modules/darwin
                ./modules/darwin/homebrew.nix
                (featuresConfig profile)
              ] ++ darwinModules;
            }
          ) (lib.filterAttrs (_: p: lib.hasSuffix "darwin" p.system) allProfiles);

          homeConfigurations = lib.mapAttrs (
            name: profile:
            let
              username = lib.elemAt (lib.splitString "@" name) 0;
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
                (featuresConfig profile)
              ] ++ homeModules;
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
