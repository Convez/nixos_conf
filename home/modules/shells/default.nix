{pkgs, config, lib, ...}:
let
  zsh = import ./zsh;
  cfg = config.myHome.shells;
  toInstall = [pkgs.meslo-lgs-nf] ++ cfg.extraFonts;
in
with lib;
{
  imports = [zsh];
  options.myHome.shells = {
    extraFonts = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "Extra fonts to install. Meslo nerd fonts is always installed.";
    };
  };
  config = {
    home.packages = toInstall;
  };
}
