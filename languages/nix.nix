{ config, pkgs, lib, ... }:
let
  convez = config.convez;
  inherit (lib) optional;
in
{
  packages = optional convez.coding.languages.nix (with pkgs;[
    nixd
    nixpkgs-fmt
  ]);
  codeExtensions = optional convez.coding.languages.nix (with pkgs.vscode-extensions;[
    jnoortheen.nix-ide
  ]);

  codeSettings = optional convez.coding.languages.nix {
    "nix.enableLanguageServer"= true;
    "nix.formatterPath"= "nixpkgs-fmt";
    "nix.serverPath"= "nixd";
  };
}