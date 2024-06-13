{ hostname, lib, ... }:
{
  networking.hostName = "${hostname}"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable =  lib.mkForce true;  # Easiest to use and most distros use this by default.

}