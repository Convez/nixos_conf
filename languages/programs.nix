{config, ... }:
let
  inherit (config) convez;
  mavenSettingsFile = ./maven_conf/${convez.coding.maven.settings}.settings.xml;

  inherit (convez.coding.languages.java) enable version;
in 
{
  programs.java = {
    package = {
      enable = enable;
      package = version;
    };
  };
  home.file.".m2/settings.xml".source = mavenSettingsFile;
}
