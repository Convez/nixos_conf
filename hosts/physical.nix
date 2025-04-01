# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ../modules/common.nix
      ../modules/localization.nix
      ../modules/networking.nix
      ../modules/gui.nix
      ../modules/audio.nix
      ../modules/services.nix
      ../modules/users.nix
    ];
}

