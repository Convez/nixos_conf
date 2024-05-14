{
  description = "My NixOS configuration, used on laptop and WSL";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager";
  };

  
  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... }: {
    nixosConfigurations = {
      # physical = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [
      #     ./hosts/physical.nix
      #   ];
      # };

      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default {
            system.stateVersion = "24.05";
            wsl.enable = true;
            wsl.defaultUser = "convez";
            wsl.docker-desktop.enable = true;
          }
          ./hosts/wsl.nix
        ];
      };
    };
  
    homeConfigurations = {
      wsl = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./home/convez.nix
        ];
      };
    };
  };
  
}
