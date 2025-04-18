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
    home.file.".config/nvim/lsp".source = ./config/lsp;
    home.file.".config/nvim/after".source = ./config/after;
    programs.neovim = {
      enable = cfg.enable;
      viAlias = true;
      vimAlias = true;
      plugins = (with pkgs.vimPlugins; [ packer-nvim ]);
    };
    home.packages = with pkgs; [
    # RipGrep needed for telescope to search
      ripgrep
      lua-language-server
    ];
  };

}
