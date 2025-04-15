{ config, pkgs, lib, ... }:
let
  cfg = config.myHome.dev.nvim;

in
with lib; {
  options.myHome.dev.nvim = {
    enable = mkEnableOption "Install and configure neovim";
  };
  config = mkIf cfg.enable {
    home.file.".config/nvim/init.lua".source = ./config/init.lua;
    home.file.".config/nvim/lua".source = ./config/lua;
    programs.neovim = {
      enable = cfg.enable;
      viAlias = true;
      vimAlias = true;
      plugins = (with pkgs.vimPlugins; [ packer-nvim ]);
    };
  };

}
