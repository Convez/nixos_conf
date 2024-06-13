{config, pkgs, lib, ... }:
let
  convez = config.convez;
  mavenSettingsFile = ./maven_conf/${convez.coding.maven.settings}.settings.xml;
in 
{
  programs.java = {
    enable = convez.coding.languages.java.enable;
    package = convez.coding.languages.java.version;
  };
  home.file.".m2/settings.xml".source = mavenSettingsFile;
}
