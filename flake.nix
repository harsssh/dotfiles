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
        in
        {
          darwinConfigurations = lib.mapAttrs (
            name: profile:
            let
              username = profile.username or name;
            in
            nix-darwin.lib.darwinSystem {
              inherit (profile) system;
              specialArgs = { inherit inputs; };
              modules = [
                home-manager.darwinModules.home-manager
                ./modules/darwin
                { dotfiles.username = username; }
                {
                  home-manager.users.${username}.imports =
                    [ ./modules/home (profile.home or { }) ] ++ homeModules;
                }
                (profile.darwin or { })
              ] ++ darwinModules;
            }
          ) (lib.filterAttrs (_: p: lib.hasSuffix "darwin" p.system) allProfiles);

          homeConfigurations = lib.mapAttrs (
            name: profile:
            let
              username = profile.username or (lib.elemAt (lib.splitString "@" name) 0);
            in
            home-manager.lib.homeManagerConfiguration {
              pkgs = inputs.nixpkgs.legacyPackages.${profile.system};
              extraSpecialArgs = { inherit inputs; };
              modules = [
                {
                  home.username = username;
                  home.homeDirectory = "/home/${username}";
                }
                ./modules/home
                (profile.home or { })
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
