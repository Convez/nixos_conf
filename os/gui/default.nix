{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.myConf.gui;
  hyprland = import ./hyprland.nix;
  awesome = import ./awesome.nix;
  gnome = import ./gnome.nix;
  kde = import ./kde.nix;
  isConfigCorrect =
    count (x: x) [ cfg.awesome.enable cfg.hyprland.enable cfg.gnome.enable cfg.kde.enable ] == 1;
in {
  options.myConf.gui = {
    enable = mkEnableOption
      "Enable the GUI (PC has a graphical interface, useless for WSL)";
  };
  imports = [ awesome gnome kde hyprland];
  config = mkIf cfg.enable {
    assertions = [{
      assertion = isConfigCorrect;
      message = "You can only enable one desktop manager at a time.";
    }];
    # Install all nerd fonts
    fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
    services.xserver.enable = true;
  };
}
