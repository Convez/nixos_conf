{ config, pkgs, lib, stateVersion, user, ... }:
let
  modules = import ../modules;
in {
  imports = [ modules ];

  config = {
    myHome = {
      git = {
        userName = "Convez";
        userEmail = "convezione@proton.me";
      };
      dev = {
        nvim.enable = true;
				defaultEditor = pkgs.neovim;
      };
      shells = {
        zsh = {
          enable = true;
          enableAutocomplete = true;
        };
        fish = {
          enable = true;
        };
        tmux = {
          enable = true;
        };
				defaultTerm = pkgs.alacritty;
      };
      cli = {
        enableKubeTools = true;
        enableTerraform = true;
        enableAzCli = true;
        enableBuildpack = true;
      };
    };
  };
}
