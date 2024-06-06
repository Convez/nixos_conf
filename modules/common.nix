{ config, pkgs, stateVersion,... }:
{
  # Define common packages to install
  environment.systemPackages = with pkgs; [
    wget
    curl
  ];
  system.stateVersion = stateVersion;
  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Allow unfree packages
  nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Enable Flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
