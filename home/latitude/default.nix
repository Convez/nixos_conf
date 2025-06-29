{ config, pkgs, lib, stateVersion, user, ... }:

let
  modules = import ../modules;
in {
  imports = [ modules ];
  config = {
    myHome = {
      gui = {
        hyprland.enable = true;
      };
      git = {
        userName = "Convez";
        userEmail = "convezione@proton.me";
      };
      shells = {
        manualDirenv = true;
        zsh = {
          enable = false;
          enableAutocomplete = true;
        };
        fish = {
          enable = true;
        };
        tmux.enable = true;
        defaultTerm = pkgs.alacritty;
      };
     dev = {
        nvim.enable = true;
        vscode.enable = false;
        defaultEditor = pkgs.neovim;
      };
    };
    home.packages = with pkgs; [
      obsidian
    ];
  };
}
