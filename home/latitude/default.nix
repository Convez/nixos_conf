{ config, pkgs, lib, stateVersion, user, ... }:

let 
  settings = import ../../settings {inherit pkgs lib;};
  languages = import ../../languages {inherit config pkgs lib;};
  dev_tools = import ../../dev_tools {inherit config pkgs lib languages;};
  languagePrograms = import ../../languages/programs.nix {inherit config pkgs lib;};
  gnome = import ../../gnome {inherit config pkgs lib;};
  kde = import ../../kde {inherit pkgs;};
  shellConf = import ../shell {inherit config pkgs;};
in 
{
  imports = [
    settings
    dev_tools
    languagePrograms
    shellConf
    kde
  ];

  convez.coding = {
    enable = true;
    ides = {
      vim = true;
      code = true;
    };
    languages = {
      java = {
        enable = true;
        version = pkgs.jdk17;
      };
      nix = true;
      cloud = true;
      typescript = true;
      rust = true;
    };
  };

  # Home manager user settings
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "${stateVersion}";
  };
  # Allow unfree packages
  nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
  };

  # Define home packages to install
  home.packages = (with pkgs;[
    ]) ++ 
    languages.packages ++ 
    gnome.packages;
  
  dconf.settings = lib.mergeAttrsList [
    gnome.dconf
  ];
}
