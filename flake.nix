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
    inputs:
    let
      mkConfigurations = import ./lib/mkConfigurations.nix { inherit inputs; };
      defaultConfigs = mkConfigurations { };
    in
    {
      inherit (defaultConfigs) darwinConfigurations homeConfigurations;
      inherit mkConfigurations;
    };
}
