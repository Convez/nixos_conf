# ~/nixos-config/hosts/wsl.nix
{ config, pkgs, ... }:
{
  imports = [
    ../modules/common.nix
    ../modules/services.nix
  ];

  # WSL specific settings
  boot.isContainer = true;
  networking.hostName = "nixos-wsl";
  time.timeZone = "Europe/Rome";

  # Define users for the WSL instance
  users.users.convez = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "$6$Lz5ZW7KQU6OnYewl$zE31RS1UTjbjmBsIlk7dTO3NzGlsiKPBh.fdSt23xOy44WzQH0nDfAhq15GfdErxZMORTpOtAZDHqB9Z5uQjI0";
  };

  # Enable sudo for the wheel group
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # Additional configurations specific to WSL
}
