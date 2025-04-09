{
  description = "My NixOS configuration, used on laptop and WSL";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixunstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Use master only if a package is not available in the other channels
    nixmaster.url = "github:NixOS/nixpkgs/master";
    
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager";
    
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    vscode-remote-workaround.url = "github:K900/vscode-remote-workaround";

    nix-direnv = {
      url = "github:nix-community/nix-direnv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  
  
  outputs = { nixpkgs, nixunstable, nixmaster, nixos-wsl, home-manager, nix-direnv, vscode-server, plasma-manager, ... }:
  let 
    supportedArchitectures = ["x86_64-linux"];
    stateVersion = "24.11";
    user = "convez";
    helper = import ./lib/sys {
      inherit nixpkgs nixunstable nixmaster home-manager;
    };

    linuxConf = with helper.mkArch (builtins.elemAt supportedArchitectures 0); {
        nixosConfigurations = {
          iso = helper.mkIso {
            inherit stable system stateVersion user;
            pkgs = stable;
          }; 
	
        latitude = helper.mkOs {
          hostname = "latitude";
          inherit stable system stateVersion user; 
          pkgs = stable;
        }; 
		  
        wsl = helper.mkOs {
          hostname = "wsl";
          inherit stable system stateVersion user;
          pkgs = stable;
          useModules = [
            nixos-wsl.nixosModules.default
            vscode-server.nixosModules.default
          ];
        };
      };
      homeConfigurations = {
        "convez@latitude" = home-manager.lib.homeManagerConfiguration {
          pkgs = unstable;
          extraSpecialArgs = {
            inherit system stateVersion user;
          };
          modules = [
            plasma-manager.homeManagerModules.plasma-manager
            ./home/latitude
          ];
        };
        "convez@wsl" = home-manager.lib.homeManagerConfiguration {
          pkgs = unstable;
          extraSpecialArgs = {
            inherit stable system stateVersion user;
          };
          modules = [
            ./home/wsl
          ];
        };
      };
    };

  in
    linuxConf //
    {
      inherit (linuxConf) homeConfigurations;
    }; 
} 
  

