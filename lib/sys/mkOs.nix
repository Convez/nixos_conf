{nixpkgs, ...}:
{pkgs, stable, stateVersion, system, hostName, useModules ? [], ...}:
  let
    hostModule = import ../../hosts/${hostName}.nix;
  in
    nixpkgs.lib.nixosSystem {
      inherit pkgs system;
      specialArgs = {
        inherit stable stateVersion;
        hostname = hostName;
      };
      modules = useModules ++ [hostModule];
  }
