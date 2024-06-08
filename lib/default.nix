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
}