{nixpkgs, nixunstable, nixmaster, home-manager, ...}:
let
  inherit (nixpkgs) mkOption types;
  mkOsDef = import ./mkOs.nix {inherit nixpkgs;};
  mkArchDef = import ./mkArch.nix {inherit nixpkgs nixunstable nixmaster home-manager;};
in
{
  mkOs = mkOsDef;
  mkArch = mkArchDef;
}
