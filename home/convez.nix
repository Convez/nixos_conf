{ config, pkgs, ... }:

{
  imports = [
    ./neovim.nix
  ];

  # Home manager user settings
  home.username = "convez";
  home.homeDirectory = "/home/convez";

  programs.home-manager.enable = true;

  # Define home packages to install
  home.packages = with pkgs; [
    wget
    curl
    git
    gh
  ];
}
