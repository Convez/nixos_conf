{
  description = "My NixOS configuration, used on laptop and WSL";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixunstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Use master only if a package is not available in the other channels
    nixmaster.url = "github:NixOS/nixpkgs/master";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager";

    vscode-server.url = "github:nix-community/nixos-vscode-server";
    vscode-remote-workaround.url = "github:K900/vscode-remote-workaround";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
		nix-linguist.url = "github:Convez/nix-linguist";
  };

  outputs = {self, nixpkgs, nixunstable, nixmaster, nixos-wsl, home-manager
    , vscode-server, plasma-manager, nix-linguist, ... }:
    let
      supportedArchitectures = [ "x86_64-linux" ];
      forEachArch = f: nixpkgs.lib.genAttrs supportedArchitectures (system: f {
				inherit system;
        pkgs = import nixpkgs { inherit system; };
      });
      stateVersion = "25.05";
      helper = import ./lib/sys {
        inherit nixpkgs nixunstable nixmaster home-manager;
      };

      linuxConf =
        with helper.mkArch (builtins.elemAt supportedArchitectures 0); {
          nixosConfigurations = {
            iso = helper.mkIso {
              inherit stable system stateVersion;
              pkgs = stable;
            };

            latitude = helper.mkOs {
              hostname = "latitude";
              inherit stable system stateVersion;
              pkgs = stable;
            };

            wsl = helper.mkOs {
              hostname = "wsl";
              inherit stable system stateVersion;
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
              extraSpecialArgs = { user = "convez"; inherit system stateVersion; };
              modules = [
                plasma-manager.homeManagerModules.plasma-manager
                ./home/latitude
              ];
            };
            "convez@wsl" = home-manager.lib.homeManagerConfiguration {
              pkgs = unstable;
              extraSpecialArgs = { user = "convez"; inherit stable system stateVersion; };
              modules = [ ./home/wsl ];
            };
          };
        };
        devShells = forEachArch ({ pkgs, system }: {
          default = pkgs.mkShell {
						inputsFrom = [nix-linguist.devShells.${system}.default];
            packages = with pkgs; [
              cachix
              lorri
              niv
              nixfmt-classic
              statix
              vulnix
              haskellPackages.dhall-nix
              nixd 
              lua-language-server
              lua
							fish-lsp
            ];
          };
        });
    in linuxConf // { inherit devShells; } // { inherit (linuxConf) homeConfigurations ; };
}

