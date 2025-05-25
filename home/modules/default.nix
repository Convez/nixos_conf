{ pkgs, config, lib, stateVersion, user, ... }:
let
in 
with lib; 
{ 
  imports = [ ./desktop ./dev_tools ./shells ]; 
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
	programs.chromium = {
		enable = true;
		package = pkgs.brave;
		extensions = [
			{ id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
			{ id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }
			{ id = "ghmbeldphafepmbegfdlkpapadhbakde"; }
		];
	};
}
