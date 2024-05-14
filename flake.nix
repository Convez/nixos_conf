{
  description = "My NixOS configuration, used on laptop and WSL";

  inputs = {
    <nixos-wsl/modules>;
    home-manager.url = "github:nix-community/home-manager";
    system.stateversion = "23.11"
  };

  
  outputs = { self, nixpkgs }: {
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
          ./hosts/wsl.nix
        ];
      };
    };
    
    homeConfigurations = {
      yourusername = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./home/home.nix
        ];
      };
    };
    
  };
}
