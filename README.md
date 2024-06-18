# nixos_conf
## Extract zscaler crt
Go to https://ip.zscaler.com/
Take the Zscaler proxy virtual IP

openssl s_client -showcerts -connect <Zscaler Proxy virtual IP>:443 </dev/null 2>/dev/null | sed -n '/-----BEGIN CERTIFICATE-----/,/-----END CERTIFICATE-----/p'  > hosts/certificates/zscaler.crt

## Generate installation ISO
nix build .#nixosConfigurations.installationIso.config.system.build.isoImage

## Switch system
In project folder run:
sudo nixos-rebuild switch --flake ./#<systemtype>

## Homemanager
In project folder run: 
nix build --option eval-cache false .#homeConfigurations.convez@<machine>.activationPackage
./result/activate