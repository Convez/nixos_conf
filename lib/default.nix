{lib,...}:
let
  inherit (lib) mkOption types;
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
}