# ~/nixos-config/hosts/wsl.nix
{ config, pkgs, ... }:
{
  imports = [
    ../modules/common.nix
    ../modules/services.nix
  ];
}
