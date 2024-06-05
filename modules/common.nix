{ config, pkgs, ... }:
{
  # Define common packages to install
  environment.systemPackages = with pkgs; [
    wget
    curl
  ];

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
