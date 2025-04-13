{ config, lib, ... }:
let
in 
with lib;
{
  options = {
    myHome.gui.awesome = { 
      enable = mkEnableOption "Enable awesome layout config";
    };
  }; 
  config = mkIf config.myHome.gui.awesome.enable {
    home.file={
      ".xinitrc".text = "awesome";
      ".config/awesome".source = ./config;
    };
  };
}
