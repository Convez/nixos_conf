{ pkgs, lib, stateVersion, config, ... }:
let
  os = import ../os;
  hw = import ./latitude/hardware-configuration.nix;
in {

  myConf = {
    bootloader = {
      enable = true;
      efi.enable = true;
    };
    gui = {
      enable = true;
      awesome = { enable = true; };
    };
    virtualisation = {
      enable = true;
      docker = true;
      virt-manager = true;
    };
    shells = {
      shells = with pkgs; [ zsh fish powershell ];
      defaultShell = pkgs.zsh;
      terminals = with pkgs; [ alacritty kitty terminator ];
      defaultTerminal = pkgs.alacritty;
      enableDirEnv = true;
    };
    networking = {
      ssh = {
        enable = true;
        keyOnly = false;
      };
      printing = true;
    };
    users = {
      create = true;
      userList = [{
        userName = "convez";
        canSudo = true;
        shell = pkgs.zsh;
        extraGroups = [ "docker" "libvritd" ];
      }];
    };
    system = {
      useFlakes = true;
      useDconf = true;
      useHomeManager = true;
    };
  };

  imports = [ os hw ];
}
