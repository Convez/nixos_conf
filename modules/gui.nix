{ pkgs, ... }:
{
  # Enable the X11 windowing system.
  services = {
    xserver.enable = true;
    
    # Enable the GNOME Desktop Environment.
    # xserver.displayManager.gdm.enable = true;
    # xserver.desktopManager.gnome.enable = true;

    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    displayManager.defaultSession = "plasmax11";
  };
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    oxygen
  ];
}