{ pkgs, lib, stateVersion, config, ... }:
let 
  physical = import ./physical.nix ;
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
    virtualisation = {
     enable = true;
      docker = true;
      virt-manager = true;
    };
    users = {
      create= true;
      userList = [
        {
          userName = "convez";
          canSudo = true;
          shell = pkgs.zsh;
          extraGroups = [ "docker" "libvritd" ];
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
