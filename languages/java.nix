{ config, pkgs, lib, ... }:
let
  inherit (config) convez;
  enableJava = convez.coding.languages.java.enable;
  javaVersion = convez.coding.languages.java.version;
in {

  packages = lib.optionals enableJava (with pkgs; [ maven ]);
  codeExtensions = lib.optionals enableJava
    (with pkgs.vscode-extensions; [ vscjava.vscode-java-pack redhat.java ]);

  codeSettings = lib.optionalAttrs enableJava {
    "java.home" = "${javaVersion}/bin/openjdk";
    "java.jdt.ls.java.home" = "${javaVersion}/bin/openjdk";
  };

  vimPlugins = lib.optionals enableJava (with pkgs.vimPlugins; [ coc-java ]);

  vimSettings = "";
}
