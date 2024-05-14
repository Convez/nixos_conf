{ config, pkgs, ... }:
{
  # Enable necessary services
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";
  services.openssh.passwordAuthentication = true;
}