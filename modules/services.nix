{ config, pkgs, ... }:
{
  # Enable necessary services
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  services.openssh.settings.PasswordAuthentication = true;
}