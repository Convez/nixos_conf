{nixpkgs, ...}:
{pkgs, stable, stateVersion, system, hostname, useModules ? [], ...}:
  let
    hostModule = import ../../hosts/${hostname}.nix;
  in
    nixpkgs.lib.nixosSystem {
      inherit pkgs system;
      specialArgs = {
        inherit stable stateVersion hostname;
      };
      modules = useModules ++ [hostModule];
  }
