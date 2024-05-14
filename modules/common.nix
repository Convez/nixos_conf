{ config, pkgs, ... }:
{
  # Define common packages to install
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    nodejs
  ];

  # Enable Flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
