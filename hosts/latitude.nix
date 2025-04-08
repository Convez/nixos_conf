{ pkgs, lib, stateVersion, config, ... }:
let 
  physical = import ./physical.nix {inherit pkgs lib; };
  bootloader = import ../modules/bootloader;
in
{

  myConf={
    bootloader = {
      enable = true;
      efi.enable = true;
    };
    gui = {
      enable = true;
      awesome = {
        enable = true;
      };
    };
    users = {
      create= true;
      userList = [
        {
          userName = "convez";
          canSudo = true;
          shell = pkgs.zsh;
          extraGroups = [ "docker" ];
        }
      ];
    };
  };

  system.stateVersion=stateVersion;
  imports = [
    physical
    ./latitude/hardware-configuration.nix
    bootloader
  ];
  environment.variables = {
    TERM = "alacritty";
  };
}
