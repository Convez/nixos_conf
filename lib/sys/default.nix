{ nixpkgs, nixunstable, nixmaster, home-manager, ... }:
let
  mkOsDef = import ./mkOs.nix { inherit nixpkgs; };
  mkArchDef =
    import ./mkArch.nix { inherit nixpkgs nixunstable nixmaster home-manager; };
  mkIsoDef = import ./mkIso.nix { inherit nixpkgs; };
in {
  mkOs = mkOsDef;
  mkArch = mkArchDef;
  mkIso = mkIsoDef;
}
