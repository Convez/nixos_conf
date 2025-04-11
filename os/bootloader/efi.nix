{ config, lib, ... }:
with lib;
let cfg = config.myConf.bootloader.efi;
in {
  config = mkIf cfg.enable {
    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
