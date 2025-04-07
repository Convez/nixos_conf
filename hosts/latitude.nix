{ pkgs, lib, stateVersion, config, ... }:
let 
  physical = import ./physical.nix {inherit pkgs lib; };
  bootloader = import ../modules/bootloader;
in
{
  myConf.bootloader = {
    enable = true;
    efi.enable = true;
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
