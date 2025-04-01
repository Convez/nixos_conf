{config, ... }:
let
  inherit (config) convez;
  mavenSettingsFile = ./maven_conf/${convez.coding.maven.settings}.settings.xml;
in 
{
  programs.java = {
    inherit (convez.coding.languages.java) enable version;
  };
  home.file.".m2/settings.xml".source = mavenSettingsFile;
}
