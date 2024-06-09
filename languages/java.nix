{ config, pkgs, lib, ... }:
let
  convez = config.convez;
in
{
  programs.java.enable = convez.coding.languages.java;

  packages = lib.optionals convez.coding.languages.java (with pkgs;[
  ]);
  codeExtensions = lib.optionals convez.coding.languages.java (with pkgs.vscode-extensions;[
    vscjava.vscode-java-pack
  ]);

  codeSettings = lib.optionalAttrs convez.coding.languages.java {
  };
  
  vimPlugins = lib.optionals convez.coding.languages.cloud(with pkgs.vimPlugins;[
    coc-java
  ]);
  
  vimSettings = ''
  '';
}