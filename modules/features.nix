{
  docker-desktop = {
    type = "darwin";
    module = ./darwin/features/docker-desktop.nix;
  };
  orbstack = {
    type = "darwin";
    module = ./darwin/features/orbstack.nix;
  };
}
