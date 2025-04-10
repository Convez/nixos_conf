{pkgs, config, lib, ...}:
let
  cfg = config.myConf.shells;
  allowedShells = [ pkgs.bash ] ++ cfg.shells;
  isShellConfigCorrect = lib.count (x: x == cfg.defaultShell) allowedShells == 1;
in
with lib;
with types;
{
  options.myConf.shells = {
    terminals = mkOption {
      type =  listOf package;
      default = [];
      description = "A list of terminal emulators packages.";
    };
    shells = mkOption {
      type =  listOf package;
      default = [];
      description = "A list of shell packages.";
    };
    defaultShell = mkOption{
      type =  package;
      default = pkgs.bash;
      description = "Default shell package.";
    };
  };
  config = {
    assertions = [
      {
        assertion = isShellConfigCorrect;
        message = "Default shell must be one of the installed shells.";
      }
    ];
    environment.systemPackages = cfg.terminals ++ cfg.shells; 
    users.defaultUserShell = cfg.defaultShell;
  };
}
