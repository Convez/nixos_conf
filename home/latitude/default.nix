{ config, pkgs, lib, stateVersion, user, ... }:

let
  modules = import ../modules;
in {
  imports = [ modules ];
  myHome = {
    gui = {
      awesome.enable = true;
    };
    git = {
      userName = "Convez";
      userEmail = "convezione@proton.me";
    };
    shells = {
      zsh = {
	enable = true;
	enableAutocomplete = true;
      };
      fish = {
	enable = true;
      };
    };
   dev = {
      nvim.enable = true;
      vscode.enable = true;
    };
  };
  # convez.coding = {
  #   enable = true;
  #   ides = {
  #     vim = true;
  #     code = true;
  #   };
  #   languages = {
  #     java = {
  #       enable = true;
  #       version = pkgs.jdk17;
  #     };
  #     nix = true;
  #     cloud = true;
  #     typescript = true;
  #     rust = true;
  #   };
  # };

  # Home manager user settings
  # TODO: Maybe move this to common user config?
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "${stateVersion}";
    sessionVariables = {
      TERM = "alacritty";
      EDITOR = "nvim";
    };
  };
  # Allow unfree packages
  # TODO: Should this be here? Wasn´t this already configured at system level?
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
  # Define home packages to install
  # TODO: Move gnome stuff to gnome config
  # TODO: Language stuff should not be installed globally. 
  # Devenv should be used in conjunction with flakes to automatically switch to useful shells
  home.packages = (with pkgs; [ alacritty ]) ;
  #   gnome.packages;

  # dconf.settings = lib.mergeAttrsList [
  #   gnome.dconf
  # ];
}
