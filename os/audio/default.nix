{ lib, pkgs, ... }: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  hardware.pulseaudio = {
		enable = lib.mkForce false;
		support32Bit = true;
		package = pkgs.pulseaudioFull;
		configFile = pkgs.writeText "default.pa" ''
		load-module module-bluetooth-policy
		load-module module-bluetooth-discover
		## module fails to load with 
		##   module-bluez5-device.c: Failed to get device path from module arguments
		##   module.c: Failed to load module "module-bluez5-device" (argument: ""): initialization failed.
		# load-module module-bluez5-device
		# load-module module-bluez5-discover
		'';
	};
 }
