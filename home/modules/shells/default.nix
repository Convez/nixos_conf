{pkgs, config, lib, ...}:
let
  zsh = import ./zsh;
  fish = import ./fish;
  tmux = import ./tmux;
  cfg = config.myHome.shells;
  toInstall = [pkgs.meslo-lgs-nf] ++ cfg.extraFonts;
in
with lib;
{
  imports = [zsh fish tmux];
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
