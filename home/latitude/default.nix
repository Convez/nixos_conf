{ config, pkgs, lib, stateVersion, user, ... }:

let 
  settings = import ../../settings {inherit pkgs lib;};
  languages = import ../../languages {inherit config pkgs lib;};
  dev_tools = import ../../dev_tools {inherit config pkgs lib languages;};
  languagePrograms = import ../../languages/programs.nix {inherit config pkgs lib;};
  gnome = import ../../gnome {inherit config pkgs lib;};
  kde = import ../../kde {inherit pkgs;};
  awesome = import ../../awesome {inherit config;};
  shellConf = import ../shell {inherit config pkgs;};
in 
{
  imports = [
    settings
    dev_tools
    languagePrograms
    shellConf
    awesome
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
  # TODO: Maybe move this to common user config?
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "${stateVersion}";
  };
  # Allow unfree packages
  # TODO: Should this be here? Wasn´t this already configured at system level?
  nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
  };
  programs.home-manager.enable = true;
  # Define home packages to install
  # TODO: Move gnome stuff to gnome config
  # TODO: Language stuff should not be installed globally. 
  # Devenv should be used in conjunction with flakes to automatically switch to useful shells
  home.packages = (with pkgs;[
    ]) ++ 
    languages.packages; 
  #   gnome.packages;
  
  # dconf.settings = lib.mergeAttrsList [
  #   gnome.dconf
  # ];
}
