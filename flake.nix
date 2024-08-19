{
  description = "My NixOS configuration, used on laptop and WSL";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    vscode-remote-workaround.url = "github:K900/vscode-remote-workaround";
  };
  
  
  outputs = { self, nixpkgs, nixos-wsl, home-manager,vscode-remote-workaround, vscode-server, ... }:
  let 
    system = "x86_64-linux";
    stateVersion = "24.05";
    user = "convez";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
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
          vscode-remote-workaround.nixosModules.default {
            vscode-remote-workaround.enable = true;
          }

          ./hosts/wsl.nix
        ];
      };
    };
  
    homeConfigurations = {
      "convez@latitude" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit system stateVersion user;
        };
        modules = [
          ./home/latitude
        ];
      };
      "convez@wsl" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit system stateVersion user;
        };
        modules = [
          ./home/wsl
        ];
      };
    };
  };
  
}
