{nixpkgs, nixunstable, nixmaster, home-manager, ...}:
let
  inherit (nixpkgs) mkOption types;
  mkOsDef = import ./mkOs.nix {inherit nixpkgs;};
  mkArchDef = import ./mkArch.nix {inherit nixpkgs nixunstable nixmaster home-manager;};
in
{
  mkEnDef = description: default: mkOption{
    inherit description default;
    type = types.bool;
    example = true;
  };
  mkEnStrDef = description: default: mkOption{
    inherit description default;
    type = types.str;
    example = "default";
  };
  mkEnPkgDef = description: default: mkOption{
    inherit description default;
    type = types.package;
    example = "pkgs.jdk";
  };
  mkOs = mkOsDef;
  mkArch = mkArchDef;
}