{ pkgs, config, lib, ... }:
let
in with lib; { imports = [ 
  ./awesome 
  ./gnome 
  # TODO: Fix KDE module. For some reason it doesn't work with wsl
  # ./kde 
  ]; 
}
