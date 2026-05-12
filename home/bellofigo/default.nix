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
        userName = "convez";
        userEmail = "enrico.panetta@canonical.com";
        sign = {
          enable = true;
          gpgKeyId = "1F2EB8BBEDD59B60";
        };
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
        defaultTerm = pkgs.kitty;
      };
     dev = {
        nvim.enable = true;
        vscode.enable = false;
        defaultEditor = pkgs.neovim;
      };
    };
    # Non-NixOS: add Nix paths to XDG_DATA_DIRS for drun/app launchers
    targets.genericLinux.enable = true;

    # Let HM manage its own binary (idiomatic standalone setup)
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      obsidian
      openai-whisper
    ];
  };
}
