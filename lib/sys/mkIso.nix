{nixpkgs, ...}:
{pkgs, stable, stateVersion, system, useModules ? [], ...}:
  let
    isoImage = "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-base.nix";
    physical = import ../../hosts/physical.nix;
    hostName = "nixos_cd";
  in
    nixpkgs.lib.nixosSystem {
      inherit pkgs system;
      specialArgs = {
        inherit stable stateVersion;
        hostname = hostName;
      };
      modules = useModules ++ [isoImage physical];
  }
