{pkgs, stateVersion, config, lib, ...}:
let
  cfg = config.myConf.system; 
in
with lib;
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
  };
}
