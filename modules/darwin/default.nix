{ username }:
{ pkgs, ... }: {
  system.stateVersion = 5;
  system.primaryUser = username;
  users.users.${username}.home = "/Users/${username}";
  nix.enable = false;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  environment.interactiveShellInit =
    let
      brewPrefix =
        if pkgs.stdenv.hostPlatform.isAarch64 then "/opt/homebrew" else "/usr/local";
    in
    ''
      eval "$(${brewPrefix}/bin/brew shellenv)"
    '';
}
