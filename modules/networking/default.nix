{pkgs, hostname, config, lib, ...}:
let
  cfg =  config.myConf.networking;

in
with lib;
{
  options.myConf.networking = {
    ssh ={
       enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable SSH server";
      };
      keyOnly = mkOption {
        type = types.bool;
        default = false;
        description = "Enable SSH key authentication only"; 
      };
    };
    printing = mkOption {
      type = types.bool;
      default = false;
      description = "Enable CUPS to print documents";
    };
  };
  config = {
    # Enable CUPS to print documents.
    services.printing.enable = cfg.printing;

    # Enable OpenSSH services
    services.openssh = {
      enable = cfg.ssh.enable;
      ports = [ 2222 ];
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = !cfg.ssh.keyOnly;
      };
    };
    networking.hostName = hostname;
    networking.networkmanager.enable =  lib.mkForce true;  # Easiest to use and most distros use this by default.
    environment.systemPackages = with pkgs; [
      librewolf
      wget
      curl
      openssl
    ];
  };
}
