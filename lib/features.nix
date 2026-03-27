{ lib }:

{
  # allModules: { featureName = { type = "home" | "darwin" | "linux"; module = ...; }; }
  # features: [ "featureName" ... ]
  # returns: { homeModules = [ ... ]; darwinModules = [ ... ]; linuxModules = [ ... ]; }
  resolve = allModules: features:
    let
      available = lib.filter (f: allModules ? ${f}) features;
      resolved = map (f: allModules.${f}) available;
    in
    {
      homeModules = map (m: m.module) (lib.filter (m: m.type == "home") resolved);
      darwinModules = map (m: m.module) (lib.filter (m: m.type == "darwin") resolved);
      linuxModules = map (m: m.module) (lib.filter (m: m.type == "linux") resolved);
    };
}
