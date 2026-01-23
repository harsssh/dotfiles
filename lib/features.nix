{ lib }:

{
  # privateModules: { featureName = { type = "home" | "darwin"; module = ...; }; }
  # features: [ "featureName" ... ]
  # returns: { home = [ modules... ]; darwin = [ modules... ]; }
  resolve = privateModules: features:
    let
      available = lib.filter (f: privateModules ? ${f}) features;
      resolved = map (f: privateModules.${f}) available;
    in
    {
      home = map (m: m.module) (lib.filter (m: m.type == "home") resolved);
      darwin = map (m: m.module) (lib.filter (m: m.type == "darwin") resolved);
    };
}
