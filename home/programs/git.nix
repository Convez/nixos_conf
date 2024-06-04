{ config, pkgs, ... }:

{
  programs.gh = {
    enable = true;
    gitCredentialsHelper.enable = true;
  };
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Convez";
    userEmail = "convezione@proton.me";
  }
}