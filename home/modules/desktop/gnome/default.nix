{ config, pkgs, lib, ... }:
let 
  extensions = pkgs.gnomeExtensions;
  cfg = config.myHome.gui.home;
in 
with lib;
{
  options = {
    myHome.gui.gnome = { 
      enable = mkEnableOption "Enable awesome layout config";
    };
  };
  config = cfg.enable {
    packages = with extensions; [ no-titlebar-when-maximized ];

    dconf = {
      "org/gnome/shell".disabled-extensions = [ ];
      "org/gnome/shell".enabled-extensions =
        [ "no-titlebar-when-maximized@alec.ninja" ];
    };
  };

}
