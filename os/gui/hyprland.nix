{pkgs, config, lib, ...}:
let
  cfg = config.myConf.gui.hyprland;
in
with lib;
{
  options.myConf.gui.hyprland.enable = mkEnableOption "Install wayland and hyprland";
	config = mkIf cfg.enable {
		programs.hyprland = {
			# Install the packages from nixpkgs
			enable = true;
			# Whether to enable XWayland
			xwayland.enable = true;
		};
	};
}

