{ pkgs, config, lib, ... }:
let
in 
with lib; 
{ 
  imports = [ ./desktop ./dev_tools ./shells ]; 
}
