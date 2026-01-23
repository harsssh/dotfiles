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

      mkDarwinConfig =
        profile:
        nix-darwin.lib.darwinSystem {
          inherit (profile) system;
          specialArgs = { inherit inputs profile; };
          modules = [
            home-manager.darwinModules.home-manager
            ./modules/darwin
            ./modules/darwin/homebrew.nix
          ];
        };

      builders = {
        darwinConfigurations = {
          predicate = p: lib.hasSuffix "darwin" p.system;
          mkConfig = mkDarwinConfig;
        };
      };
    in
    builtins.mapAttrs (
      _: b:
      builtins.mapAttrs (_: b.mkConfig) (lib.filterAttrs (_: b.predicate) profiles)
    ) builders;
}
