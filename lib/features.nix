{ lib }:

{
  # type "home"   -> home-manager module (全プラットフォーム共通)
  # type "darwin" -> nix-darwin module (macOS のみ)
  # type "linux"  -> home-manager module (Linux standalone のみ)
  resolve = allModules: features:
    let
      unknown = lib.filter (f: !(allModules ? ${f})) features;
      _ = map (f: builtins.trace "warning: unknown feature '${f}'" null) unknown;
      available = lib.filter (f: allModules ? ${f}) features;
      resolved = map (f: allModules.${f}) available;
    in
    {
      homeModules = map (m: m.module) (lib.filter (m: m.type == "home") resolved);
      darwinModules = map (m: m.module) (lib.filter (m: m.type == "darwin") resolved);
      linuxModules = map (m: m.module) (lib.filter (m: m.type == "linux") resolved);
    };
}
