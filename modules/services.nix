{ config, pkgs, ... }:
{
  # Enable necessary services
  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
  };
}