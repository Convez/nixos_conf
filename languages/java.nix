{ config, pkgs, lib, ... }:
let
  convez = config.convez;
  enableJava = convez.coding.languages.java.enable;
  javaVersion = convez.coding.languages.java.version;
in
{

  packages = lib.optionals enableJava (with pkgs;[
    maven
  ]);
  codeExtensions = lib.optionals enableJava (with pkgs.vscode-extensions;[
    vscjava.vscode-java-pack
    redhat.fabric8-analytics
  ]);

  codeSettings = lib.optionalAttrs enableJava {
    "java.home"= "${javaVersion}/bin/openjdk";
    "java.jdt.ls.java.home"= "${javaVersion}/bin/openjdk";
  };
  
  vimPlugins = lib.optionals enableJava(with pkgs.vimPlugins;[
    coc-java
  ]);
  
  vimSettings = ''
  '';
}