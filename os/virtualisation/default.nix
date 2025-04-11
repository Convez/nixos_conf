{ pkgs, config, lib, ... }:
let cfg = config.myConf.virtualisation;
in with lib; {
  options.myConf.virtualisation = {
    enable = mkEnableOption "Enable virtualisation support";
    docker = mkEnableOption "Enable docker support";
    virt-manager = mkEnableOption "Enable virt-manager support";
  };
  config = mkIf cfg.enable {
    # Enable docker suppport
    virtualisation.docker.enable = cfg.docker;
    virtualisation.libvirtd.enable = cfg.virt-manager;
    virtualisation.spiceUSBRedirection.enable = cfg.virt-manager;
    programs.virt-manager.enable = cfg.virt-manager;
  };
}

