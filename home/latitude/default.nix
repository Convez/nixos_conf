{ config, pkgs, lib, stateVersion, user, ... }:

let 
  settings = import ../../settings;
in 
{
  imports = [
    settings
    ../../dev_tools/neovim.nix
    ../../dev_tools/git.nix
    ../../dev_tools/vscodium.nix
  ];

  # Home manager user settings
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "${stateVersion}";
  programs.home-manager.enable = true;

  # Allow unfree packages
  nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
  };

  # Define home packages to install
  home.packages = with pkgs; [
    nixd
    nixpkgs-fmt
  ];

}
