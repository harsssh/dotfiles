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
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }:
    let
      username = "kentaro.mizuki";
    in
    {
      darwinConfigurations.work = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          home-manager.darwinModules.home-manager
          ./modules/homebrew.nix
          {
            # nix-darwin
            system.stateVersion = 5;
            system.primaryUser = username;
            users.users.${username}.home = "/Users/${username}";
            nix.enable = false;

            # Home Manager
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} =
              { pkgs, ... }:
              {
                home.username = username;
                home.homeDirectory = "/Users/${username}";
                home.stateVersion = "24.11";
                home.packages = with pkgs; [
                  nixfmt
                ];
                programs.home-manager.enable = true;
              };
          }
        ];
      };
    };
}
