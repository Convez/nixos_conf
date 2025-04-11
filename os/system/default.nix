{pkgs, stateVersion, config, lib, ...}:
with lib;
let
  cfg = config.myConf.system; 
in
{
  options.myConf.system = {
    useFlakes = mkOption {
      type = types.bool;
      default = false;
      description = "Use flakes";
    };
    useDconf = mkOption {
      type = types.bool;
      default = false;
      description = "Use dconf";
    };
    useHomeManager = mkEnableOption "Enable home manager";
  };
  config = {
    system.stateVersion = stateVersion;
    # Enable Flakes
    nix = {
      package = pkgs.nixVersions.stable;
      extraOptions = mkIf cfg.useFlakes ''
        experimental-features = nix-command flakes
      '';
    };
    # Enable dconf
    programs.dconf.enable = cfg.useDconf;
    environment.systemPackages = with pkgs; mkIf cfg.useHomeManager [
      home-manager
    ];
  };
}
