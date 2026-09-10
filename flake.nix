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
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alacritty-theme = {
      url = "github:alacritty/alacritty-theme";
      flake = false;
    };
  };

  outputs =
    { self, nixpkgs, nix-darwin, home-manager, nixvim, ... }@inputs:
    {
      homeModules.default = {
        imports = [
          nixvim.homeModules.nixvim
          ./modules/home
        ];
        _module.args.inputs = inputs;
      };

      darwinModules.default = {
        imports = [
          home-manager.darwinModules.home-manager
          ./modules/darwin
        ];
        home-manager.sharedModules = [ self.homeModules.default ];
      };

      # CI 用。実機の構成は dotfiles-private で定義する
      darwinConfigurations.ci-darwin = nix-darwin.lib.darwinSystem {
        modules = [
          self.darwinModules.default
          {
            nixpkgs.hostPlatform = "aarch64-darwin";
            system.primaryUser = "runner";
          }
        ];
      };

      homeConfigurations."runner@ci-linux" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          self.homeModules.default
          {
            home.username = "runner";
            home.homeDirectory = "/home/runner";
          }
        ];
      };
    };
}
