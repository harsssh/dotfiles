{ username }:
{ ... }: {
  system.stateVersion = 5;
  system.primaryUser = username;
  users.users.${username}.home = "/Users/${username}";
  nix.enable = false;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
}
