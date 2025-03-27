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
  
  
  outputs = { self, nixpkgs, nixunstable, nixmaster, nixos-wsl, home-manager, nix-direnv, vscode-remote-workaround, vscode-server, plasma-manager, ... }:
  let 
    supportedArchitectures = ["x86_64-linux"];
    stateVersion = "25.05";
    user = "convez";
    # Here I configure the nixpkgs for a given system (system=architecture)
    # This allows easy evolution in case I need to add support for ARM or Darwin (grz Massi)
    pkgConf = system: rec{
      inherit system;
      # This is equivalent to nixpgks.config
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
      # Easy access to the nixpkg channels
      stable = import nixpkgs { inherit system config; };
      unstable = import nixunstable { inherit system config; };
      master = import nixmaster { inherit system config; };

      # Use project library functions
      helper = import ./lib.nix { inherit stable; };
    };
    linuxConf = with pkgConf "x86_64-linux"; {
      nixosConfigurations = {
        installationIso = nixpkgs.lib.nixosSystem {
          system = "${system}";
          specialArgs = {
            inherit system stateVersion user;
            hostname = "nixos_cd";
          };
          modules = [
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
            ./hosts/physical.nix
          ];
        };
        latitude = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system stateVersion user;
            hostname = "latitude";
          };
          system.stateVersion = "${stateVersion}";
          modules = [
            ./modules/efi.nix
            ./hosts/physical.nix
            ./hosts/latitude/hardware-configuration.nix
          ];
        };

        wsl = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            nixos-wsl.nixosModules.default {
              networking.hostName = "wsl";
              system.stateVersion = stateVersion;
              wsl.enable = true;
              wsl.defaultUser = "${user}";
              wsl.docker-desktop.enable = true;
            }
            vscode-server.nixosModules.default
            ({ config, pkgs, ... }: {
              services.vscode-server.enable = true;
            })
            ./hosts/wsl.nix
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
            inherit system stateVersion user;
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
      homeConfigurations = linuxConf.homeConfigurations;
    } 
  ;
  
}
