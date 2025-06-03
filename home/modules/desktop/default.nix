{ pkgs, config, lib, ... }:
let
in with lib; { imports = [ 
  ./awesome 
  ./gnome 
  ./hyprland
  # TODO: Fix KDE module. For some reason it doesn't work with wsl
  # ./kde 
  ]; 
  config.home.file."backgrounds".source = ./assets;
}
