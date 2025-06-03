{ config, lib, ... }:
with lib;
let cfg = config.myConf.bootloader.grub;
in {
  config = mkIf cfg.enable {
    boot.loader.grub = {
       enable = cfg.enable;
       efiSupport = true;
       useOSProber = true;
       device = cfg.device;
    };
  };
}
