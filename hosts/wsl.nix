# ~/nixos-config/hosts/wsl.nix
{ config, pkgs, ... }:
let 
  system = import ../modules/system;
  shells = import ../modules/shells;
  networking = import ../modules/networking;
  users = import ../modules/users ;
in
{
  imports = [
    system
    shells 
    networking
    users
  ];

  myConf={
    users = {
      create= true;
      userList = [
        {
          userName = "convez";
          canSudo = true;
          shell = pkgs.zsh;
          extraGroups = [ "docker" ];
        }
      ];
    };
    shells = {
      shells = with pkgs; [ 
        zsh 
        fish
        powershell
      ];
      defaultShell = pkgs.zsh;
    };
  };
  programs.nix-ld = {
    enable = true;
  };
  wsl.enable = true;
  wsl.defaultUser = "convez";
  systemd.services.docker-sock = {
      description = "Docker Desktop socket link";
      script = ''
        ln -s -f /mnt/wsl/docker-desktop/shared-sockets/guest-services/docker.sock /var/run/docker.sock
        /run/current-system/sw/bin/setfacl --modify user:${config.wsl.defaultUser}:rw /var/run/docker.sock
      '';
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Restart = "on-failure";
        RestartSec = "30s";
      };
    };
  security.pki.certificateFiles = [ 
    "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt" 
    "${./certificates/af.zscaler.crt}"  
  ];
}
