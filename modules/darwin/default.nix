{ lib, config, inputs, ... }:
let
  username = config.dotfiles.username;
  homeDirectory = "/Users/${username}";
in
{
  imports = [
    ./homebrew.nix
    ./system.nix
    ./features/orbstack.nix
    ./features/docker-desktop.nix
  ];

  options.dotfiles.username = lib.mkOption {
    type = lib.types.str;
    description = "The primary user's username.";
  };

  config = {
    system.stateVersion = 5;
    system.primaryUser = username;
    users.users.${username}.home = homeDirectory;
    nix.enable = false;
    security.pam.services.sudo_local.touchIdAuth = true;

    environment.etc."nix/nix.custom.conf".text = import ../nix-custom-conf.nix username;

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.backupFileExtension = "backup";
    home-manager.extraSpecialArgs = { inherit inputs; };
    home-manager.users.${username} = {
      home.username = username;
      home.homeDirectory = homeDirectory;
    };
  };
}
