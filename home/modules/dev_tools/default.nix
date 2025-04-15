{ config, pkgs, lib, languages, ... }:
let
  neovim = import ./neovim ;
  vscodium = import ./vscode; 
  cfg = config.myHome.git;
in 
with lib;{
  imports = [ neovim vscodium ];

  options = {
    myHome.git = {
      userName = mkOption {
        type = types.str;
        description = "Git user name";
      };
      userEmail = mkOption {
        type = types.str;
        description = "Git user email";
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
    };
  };
}
