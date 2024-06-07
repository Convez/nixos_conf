{ config, pkgs, lib, stateVersion, user, ... }:

{
  imports = [
    ../dev_tools/neovim.nix
    ../dev_tools/git.nix
    ../dev_tools/code.nix
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
