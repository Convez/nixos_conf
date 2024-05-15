{ config, pkgs, ... }:
{
  # Define common packages to install
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    nodejs
    gh
  ];

  # Enable Flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
