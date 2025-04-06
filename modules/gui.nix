{ pkgs, ... }:
{
  # Enable the X11 windowing system.
  services = {
    xserver={
    	enable = true;

    windowManager.awesome={
	  enable = true;
	  luaModules = with pkgs.luajitPackages; [
	    luarocks
	    luadbi-mysql
      lgi
	  ];
	};
 
    # desktopManager.plasma6.enable = true;
   };
    
  displayManager={
    sddm.enable = true;
    defaultSession = "none+awesome";
  };
    # Enable the GNOME Desktop Environment.
    # xserver.displayManager.gdm.enable = true;
    # xserver.desktopManager.gnome.enable = true;
  };
  # environment.plasma6.excludePackages = with pkgs.kdePackages; [
  #   plasma-browser-integration
  #   oxygen
  # ];
}
