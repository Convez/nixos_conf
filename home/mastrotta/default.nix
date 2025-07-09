{ config, pkgs, lib, stateVersion, user, ... }:

let
  modules = import ../modules;
in {
  imports = [ modules ];
  myHome = {
    git = {
      userName = "Convez";
      userEmail = "convezione@proton.me";
    };
    shells = {
      manualDirenv = true;
      fish = {
        enable = true;
      };
    };
   dev = {
      nvim.enable = true;
      vscode.enable = false;
      defaultEditor = pkgs.neovim;
    };
  };
}
