{ config, pkgs, stateVersion, user, ... }:

{
  imports = [
    ./neovim.nix
  ];

  # Home manager user settings
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "${stateVersion}";
  programs.home-manager.enable = true;

  # Define home packages to install
  home.packages = with pkgs; [

  ];
}
