{ config, pkgs, lib, languages, ... }:
let
  neovim = import ./neovim ;
  vscodium = import ./vscode; 
  cli = import ./cli;
  cfg = config.myHome.git;
in 
with lib;{
  imports = [ neovim vscodium cli ];

  options = {
    myHome= {
      git = {
        userName = mkOption {
          type = types.str;
          description = "Git user name";
        };
        userEmail = mkOption {
          type = types.str;
          description = "Git user email";
        };
      };
      dev = {
        defaultEditor = mkOption {
          type = types.package;
          description = "Default editor. This sets EDITOR env variable and is reused in gui config (ex. Hyprland/AwesomeWM)";
        };
      };
    };
  };
  config = {
    # Git and github shell are always installed
    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
    programs.git = {
      enable = true;
      lfs.enable = true;
      userName = cfg.userName;
      userEmail = cfg.userEmail;
      extraConfig = {
        pull.rebase = true;
        diff = {
          tool = "vimdiff";
          mnemonicprecix = true;
        };
      };
      
    };
    home.sessionVariables.EDITOR = config.myHome.dev.defaultEditor.meta.mainProgram;
  };
}
