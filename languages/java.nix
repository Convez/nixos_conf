{ config, pkgs, lib, ... }:
let
  convez = config.convez;
in
{

  packages = lib.optionals convez.coding.languages.java (with pkgs;[
    maven
  ]);
  codeExtensions = lib.optionals convez.coding.languages.java (with pkgs.vscode-extensions;[
    vscjava.vscode-java-pack
  ]);

  codeSettings = lib.optionalAttrs convez.coding.languages.java {
  };
  
  vimPlugins = lib.optionals convez.coding.languages.java(with pkgs.vimPlugins;[
    coc-java
  ]);
  
  vimSettings = ''
  '';
}