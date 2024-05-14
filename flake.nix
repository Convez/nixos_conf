{
  description = "My NixOS configuration, used on laptop and WSL";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
  };
}
