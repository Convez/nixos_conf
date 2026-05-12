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
      ".config/hypr/hyprpaper.conf".source = ./config/hyprpaper.conf;
      ".config/mako".source = ./config/mako;
      ".config/wofi/style.css".source = ./config/wofi_style.css;
      ".config/waybar".source = ./config/waybar;
      ".scripts".source = ./scripts;
    };
    home.packages = with pkgs; [
      wofi
      caja
      waybar
      slurp
      grim
      swappy
      wl-clipboard
      hyprpicker
      hyprpaper
      libnotify
      grimblast
      hyprlock
      networkmanagerapplet
    ];
  };
}


