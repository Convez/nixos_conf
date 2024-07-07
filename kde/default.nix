{pkgs, lib, ... }:
let
in 
{

  packages = with pkgs;[
    sweet-nova
  ];
  platformTheme = "qtct";
  styleName = "Sweet";
  
}