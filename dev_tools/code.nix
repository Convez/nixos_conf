{config, pkgs, lib, ...}:
let
  inherit (lib) mkOption types;
  cfg = config.convez.coding;
  mkEnDef = description: default: mkOption{
    inherit description default;
    type = types.bool;
    example = true;
  };
in {
  options.my-modules.coding = {
    enable = mkEnDef "Enable coding goodies" false;
    languages = {
      c = mkEnDef "Enable Clang tooling" false;
      c_sharp = mkEnDef "Enable C# tooling" false;
      go = mkEnDef "Enable Go tooling" false;
      haskell = mkEnDef "Enable Haskell tooling" false;
      java = mkEnDef "Enable Java tooling" false;
      javascript = mkEnDef "Enable Javascript tooling" false;
      json = mkEnDef "Enable JSON tooling" false;
      kotlin = mkEnDef "Enable Kotlin tooling" false;
      lua = mkEnDef "Enable LUA tooling" false;
      misc = mkEnDef "Enable other stuff (git, docker, ...)" false;
      nix = mkEnDef "Enable Nix tooling" false;
      purescript = mkEnDef "Enable Purescript tooling" false;
      racket = mkEnDef "Enable racket tooling" false;
      rust = mkEnDef "Enable Rust tooling" false;
      scripting = mkEnDef "Enable scripting tooling" false;
      terraform = mkEnDef "Enable Terraform tooling" false;
      yaml = mkEnDef "Enable YAML tooling" false;
      typst = mkEnDef "Enable Typst tooling" false;
    };
  };
}
