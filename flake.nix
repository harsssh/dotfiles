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

      mkDarwinConfig = extraModules: profileName: profile:
        nix-darwin.lib.darwinSystem {
          inherit (profile) system;
          specialArgs = { inherit inputs profile profileName; };
          modules = [
            home-manager.darwinModules.home-manager
            ./modules/darwin
            ./modules/darwin/homebrew.nix
          ] ++ extraModules;
        };

      mkDarwinConfigurations = extraModules:
        lib.mapAttrs (mkDarwinConfig extraModules) darwinProfiles;
    in
    {
      darwinConfigurations = mkDarwinConfigurations [ ];

      lib = { inherit mkDarwinConfig mkDarwinConfigurations; };
    };
}
