{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.myConf.bootloader;
  efiModule = import ./efi.nix;
	grubModule = import ./grub.nix;
in {
  options.myConf = {
    bootloader.enable = mkEnableOption "Enable the bootloader";
    bootloader.efi.enable = mkEnableOption "Enable the EFI bootloader";
    bootloader.grub.enable = mkEnableOption "Enable the GRUB bootloader";
		bootloader.grub.device = mkOption {
			type = lib.types.str;
		};
  };
  imports = [
    efiModule
		grubModule
    # at one point we will have a grub module 
  ];
  config = mkIf cfg.enable {
  };
}
