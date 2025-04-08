{ hostname, lib, ... }:
{
  networking.hostName = "${hostname}"; # Define your hostname.
  networking.networkmanager.enable =  lib.mkForce true;  # Easiest to use and most distros use this by default.
}