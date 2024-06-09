{ config, pkgs, lib, stateVersion, user, ... }:

let 
  settings = import ../../settings {inherit lib;};
  languages = import ../../languages {inherit config pkgs lib;};
  dev_tools = import ../../dev_tools {inherit config pkgs lib languages;};
  gnome = import ../../gnome {inherit config pkgs lib;};
in 
{
  imports = [
    settings
    dev_tools
  ];

  convez.coding = {
    enable = true;
    ides = {
      vim = true;
      code = true;
    };
    languages = {
      java = true;
      nix = true;
      cloud = true;
    };
  };

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
  home.packages = languages.packages ++ 
    gnome.packages;
  
  dconf.settings = lib.mergeAttrsList [
    gnome.dconf
  ];
}
