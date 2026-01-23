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
    {
      nixpkgs,
      nix-darwin,
      home-manager,
      alacritty-theme,
      ...
    }:
    let
      system = "aarch64-darwin";
      username = "kentaro.mizuki";
    in
    {
      darwinConfigurations.work = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          home-manager.darwinModules.home-manager
          (import ./modules/darwin.nix { inherit username; })
          ./modules/homebrew.nix
          {
            home-manager.extraSpecialArgs = { inherit alacritty-theme; };
            home-manager.users.${username} = {
              home.username = username;
              home.homeDirectory = "/Users/${username}";
              imports = [ ./modules/home.nix ];
            };
          }
        ];
      };
    };
}
