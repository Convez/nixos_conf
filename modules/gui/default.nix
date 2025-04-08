
{pkgs, config, lib, ...}:
with lib;
let
  cfg = config.myConf.gui;
  awesome = import ./awesome.nix;
  gnome = import ./gnome.nix;
  kde = import ./kde.nix;
  isConfigCorrect = count (x: x) [cfg.awesome.enable cfg.gnome.enable cfg.kde.enable] == 1;
in
{
  options.myConf.gui = {
    enable = mkEnableOption "Enable the GUI (PC has a graphical interface, useless for WSL)" ;
  };
  imports = [
    awesome
    gnome
    kde
  ];
  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = isConfigCorrect;
        message = "You can only enable one desktop manager at a time.";
      }
    ];

    services.xserver.enable = true;
  };
}