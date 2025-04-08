{pkgs, config, lib, ...}:
with lib;
let
  guiCfg = config.myConf.gui;
  cfg = guiCfg.kde;
in
{
  options.myConf.gui.kde= {
    enable = mkEnableOption "Enable KDE Desktop Environment";
  };

  config = mkIf cfg.enable{
    services={
      xserver = {
        desktopManager.plasma6.enable = true;
      };
    };
  };
}