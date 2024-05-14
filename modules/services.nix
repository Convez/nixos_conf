{ config, pkgs, ... }:
{
  # Enable necessary services
  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };
}