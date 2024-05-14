{ config, pkgs, ... }:
{
  # Enable necessary services
  services.openssh.enable = true;
  services.openssh.settings.permitRootLogin = "yes";
  services.openssh.settings.passwordAuthentication = true;
}