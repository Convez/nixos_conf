# ~/nixos-config/hosts/wsl.nix
{ config, pkgs, ... }:
let os = import ../os;
in {
  imports = [ os ];

  myConf = {
    users = {
      create = true;
      userList = [{
        userName = "convez";
        canSudo = true;
        shell = pkgs.fish;
        extraGroups = [ "docker" ];
      }];
    };
    localization = {
      lang = "en_US.UTF-8";
    };
    shells = {
      shells = with pkgs; [ zsh fish powershell ];
      defaultShell = pkgs.bash;
      terminals = with pkgs; [ tmux kitty ];
      defaultTerminal = pkgs.kitty;
      enableDirEnv = true;
    };
    system = {
      useFlakes = true;
      useDconf = true;
      useHomeManager = true;
    };
  };
  # This is needed for the rust analyzer
  # TODO: However, if I manage to get devenv to work, I can remove this
  programs.nix-ld = { enable = true; };
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
