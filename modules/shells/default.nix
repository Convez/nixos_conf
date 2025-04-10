{pkgs, config, lib, ...}:
let
  cfg = config.myConf.shells;
in
with lib;
{
  options.myConf.shells = {
    terminals = lib.mkOption {
      type = with lib.types; listOf package;
      default = [];
      description = "A list of terminal emulators packages.";
    };
    shells = lib.mkOption {
      type = with lib.types; listOf package;
      default = [];
      description = "A list of shell packages.";
    };
  };
  config = {
    environment.systemPackages = cfg.terminals ++ cfg.shells; 
  };
}
