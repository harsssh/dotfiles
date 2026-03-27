{
  ci-darwin = {
    system = "aarch64-darwin";
    username = "runner";
    features = [ ];
  };

  "runner@ci-linux" = {
    system = "x86_64-linux";
    features = [ ];
  };
}
