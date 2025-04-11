{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.myConf.bootloader;
  # XOR efi and grub
  isCfgCorrect = (!cfg.efi.enable && cfg.grub.enable)
    || (cfg.efi.enable && !cfg.grub.enable);
  efiModule = import ./efi.nix;
in {
  options.myConf = {
    bootloader.enable = mkEnableOption "Enable the bootloader";
    bootloader.efi.enable = mkEnableOption "Enable the EFI bootloader";
    bootloader.grub.enable = mkEnableOption "Enable the GRUB bootloader";
  };
  imports = [
    efiModule
    # at one point we will have a grub module 
  ];
  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = isCfgCorrect;
        message =
          "Cannot enable both EFI and GRUB bootloaders at the same time.";
      }
      {
        assertion = !cfg.grub.enable;
        message = "GRUB bootloader not yet supported.";
      }
    ];
  };
}
