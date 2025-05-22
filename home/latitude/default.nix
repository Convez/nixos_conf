{ config, pkgs, lib, stateVersion, user, ... }:

let
  modules = import ../modules;
in {
  imports = [ modules ];
  myHome = {
    gui = {
      awesome.enable = true;
			hyprland.enable = true;
    };
    git = {
      userName = "Convez";
      userEmail = "convezione@proton.me";
    };
    shells = {
      zsh = {
				enable = true;
				enableAutocomplete = true;
      };
      fish = {
				enable = true;
      };
			defaultTerm = pkgs.alacritty;
    };
   dev = {
      nvim.enable = true;
      vscode.enable = true;
			defaultEditor = pkgs.neovim;
    };
  };
}
