# nixos_conf

## Switch system
In project folder run:
sudo nixos-rebuild switch --flake ./#<systemtype>

## Homemanager
In project folder run: 
nix build --option eval-cache false .#homeConfigurations.convez.activationPackage
./result/activate