# nixos_conf
## Extract zscaler crt
openssl s_client -showcerts -connect jsonplaceholder.typicode.com:443 </dev/null 2>/dev/null | sed -n '/-----BEGIN CERTIFICATE-----/,/-----END CERTIFICATE-----/p'  > hosts/certificates/zscaler.crt

## Generate installation ISO
nix build .#nixosConfigurations.installationIso.config.system.build.isoImage

## Switch system
In project folder run:
sudo nixos-rebuild switch --flake ./#<systemtype>

## Homemanager
In project folder run: 
nix build --option eval-cache false .#homeConfigurations.convez@<machine>.activationPackage
./result/activate