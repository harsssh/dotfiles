{ lib }:

{
  # privateModules: { featureName = { type = "home" | "darwin"; module = ...; }; }
  # features: [ "featureName" ... ]
  # returns: { homeModules = [ ... ]; darwinModules = [ ... ]; }
  resolve = privateModules: features:
    let
      available = lib.filter (f: privateModules ? ${f}) features;
      resolved = map (f: privateModules.${f}) available;
    in
    {
      homeModules = map (m: m.module) (lib.filter (m: m.type == "home") resolved);
      darwinModules = map (m: m.module) (lib.filter (m: m.type == "darwin") resolved);
    };
}
