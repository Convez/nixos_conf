{ config, pkgs, stateVersion, user, ... }:

{
  imports = [
    ./programs/neovim.nix
    ./programs/git.nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.convez = {
    isNormalUser = true;
    description = "convez";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Home manager user settings
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "${stateVersion}";
  programs.home-manager.enable = true;

  # Define home packages to install
  home.packages = with pkgs; [
  ];
}
