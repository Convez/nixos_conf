{pkgs, config, lib, ...}:
let
	cfg = config.myHome.gui.hyprland;
in
with lib;
{
  options = {
    myHome.gui.hyprland= { 
      enable = mkEnableOption "Enable hyprland layout config";
    };
  }; 
	config= mkIf cfg.enable {
		home.file = {
			".config/hypr/hyprland.conf".source = ./config/hyprland.conf;
		};
	};
}


