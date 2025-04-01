{ pkgs, lib, stateVersion, ... }:
let 
  physical = import ./physical.nix {inherit pkgs lib; };
in
{
  system.stateVersion=stateVersion;
  imports = [
    physical
    ./latitude/hardware-configuration.nix
    ../modules/efi.nix
  ];
}
