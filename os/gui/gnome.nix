{pkgs, config, lib, ...}:
with lib;
let
  guiCfg = config.myConf.gui;
  cfg = guiCfg.gnome;
in
{
  options.myConf.gui.gnome = {
    enable = mkEnableOption "Enable Gnome Desktop Environment";
  };

  config = mkIf cfg.enable {
    # Enable the GNOME Desktop Environment.
    services={
      xserver = {
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
    };
  };
}