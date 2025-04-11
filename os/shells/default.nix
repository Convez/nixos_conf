{ pkgs, config, lib, ... }:
let
  cfg = config.myConf.shells;
  allowedTerminals = [ pkgs.xterm ] ++ cfg.terminals;
  isTerminalConfigCorrect =
    lib.count (x: x == cfg.defaultTerminal) allowedTerminals == 1;
  allowedShells = [ pkgs.bash ] ++ cfg.shells;
  isShellConfigCorrect = lib.count (x: x == cfg.defaultShell) allowedShells
    == 1;
in with lib;
with types; {
  options.myConf.shells = {
    terminals = mkOption {
      type = listOf package;
      default = [ ];
      description = "A list of terminal emulators packages.";
    };
    defaultTerminal = mkOption {
      type = package;
      default = pkgs.xterm;
      description =
        "Change default terminal emulator package. (xterm is used by default)";
    };
    shells = mkOption {
      type = listOf package;
      default = [ ];
      description = "A list of shell packages.";
    };
    defaultShell = mkOption {
      type = package;
      default = pkgs.bash;
      description = "Change default shell package. (bash is used by default)";
    };
    enableDirEnv = mkEnableOption "Enable direnv";
  };
  config = {
    assertions = [
      {
        assertion = isTerminalConfigCorrect;
        message = "Default terminal must be one of the installed terminals.";
      }
      {
        assertion = isShellConfigCorrect;
        message = "Default shell must be one of the installed shells.";
      }
    ];
    environment.systemPackages = cfg.terminals ++ cfg.shells;
    users.defaultUserShell = cfg.defaultShell;
    programs.direnv.enable = cfg.enableDirEnv;

    environment.variables = { TERM = cfg.defaultTerminal.pname; };
  };
}
