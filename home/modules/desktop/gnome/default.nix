{ config, pkgs, lib, ... }:
let 
  extensions = pkgs.gnomeExtensions;
  cfg = config.myHome.gui.gnome;
in 
with lib;
{
  options = {
    myHome.gui.gnome = { 
      enable = mkEnableOption "Enable awesome layout config";
    };
  };
  config = mkIf cfg.enable {
    home.packages = with extensions; [ no-titlebar-when-maximized ];

    dconf.settings = {
      "org/gnome/shell".disabled-extensions = [ ];
      "org/gnome/shell".enabled-extensions =
        [ "no-titlebar-when-maximized@alec.ninja" ];
    };
  };

}
