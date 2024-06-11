{config, pkgs, ... }:
let
  convez = config.convez;
in 
{
  programs.java = {
    enable = convez.coding.languages.java;
    package = pkgs.jdk;
  };
}