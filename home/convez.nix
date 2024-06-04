{ config, pkgs, stateVersion, user, ... }:

{
  imports = [
    ./programs/neovim.nix
    ./programs/git.nix
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
