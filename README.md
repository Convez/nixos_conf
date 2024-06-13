# nixos_conf
## Generate installation ISO
nix build .#nixosConfigurations.installationIso.config.system.build.isoImage

## Switch system
In project folder run:
sudo nixos-rebuild switch --flake ./#<systemtype>

## Homemanager
In project folder run: 
nix build --option eval-cache false .#homeConfigurations.convez@<machine>.activationPackage
./result/activate