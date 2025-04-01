{ config, pkgs, lib, ... }:
let
  inherit (config) convez;
in
{
  packages = lib.optionals convez.coding.languages.nix (with pkgs;[
    nixd
    nixpkgs-fmt
  ]);
  codeExtensions = lib.optionals convez.coding.languages.nix (with pkgs.vscode-extensions;[
    jnoortheen.nix-ide
  ]);

  codeSettings = lib.optionalAttrs convez.coding.languages.nix {
    "nix.enableLanguageServer"= true;
    "nix.formatterPath"= "nixpkgs-fmt";
    "nix.serverPath"= "nixd";
  };

  vimPlugins = lib.optionals convez.coding.languages.nix(with pkgs.vimPlugins;[
      vim-nix
  ]);
  
  vimSettings = ''
  '';
}