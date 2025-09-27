{pkgs, config, lib, ...}:
let
  cfg = config.myConf.gaming;
in
with lib;
{
  options.myConf.gaming = {
    enable = mkEnableOption "Enable gaming";
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;
    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}


