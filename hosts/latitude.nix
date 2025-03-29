{ config, pkgs, stateVersion, hostName ,... }:
let 
  physical = import ./physical.nix;
  users = import ../modules/users.nix {inherit pkgs;};
in
{
  system.stateVersion=stateVersion;
  imports = [
    physical
    users
  ];
}
