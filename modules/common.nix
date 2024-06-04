{ config, pkgs, ... }:
{
  # Define common packages to install
  environment.systemPackages = with pkgs; [
    wget
    curl
  ];

  # Enable Flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
