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
      profiles = import ./profiles.nix;

      mkDarwinConfig =
        profileName:
        let
          profile = profiles.${profileName};
        in
        nix-darwin.lib.darwinSystem {
          inherit (profile) system;
          specialArgs = { inherit inputs profile; };
          modules = [
            home-manager.darwinModules.home-manager
            ./modules/darwin
            ./modules/darwin/homebrew.nix
          ];
        };
    in
    {
      darwinConfigurations.work = mkDarwinConfig "work";
      darwinConfigurations.personal = mkDarwinConfig "personal";
    };
}
