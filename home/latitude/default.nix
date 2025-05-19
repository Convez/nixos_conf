{ config, pkgs, lib, stateVersion, user, ... }:

let
  modules = import ../modules;
in {
  imports = [ modules ];
  myHome = {
    gui = {
      awesome.enable = true;
			hyprland.enable = true;
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
			defaultTerm = pkgs.alacritty;
    };
   dev = {
      nvim.enable = true;
      vscode.enable = true;
			defaultEditor = pkgs.neovim;
    };
  };

  # Home manager user settings
  # TODO: Maybe move this to common user config?
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "${stateVersion}";
  };
  # Define home packages to install
  # TODO: Move gnome stuff to gnome config
  # TODO: Language stuff should not be installed globally. 
  # Devenv should be used in conjunction with flakes to automatically switch to useful shells
  home.packages = (with pkgs; [ alacritty ]) ;
}
