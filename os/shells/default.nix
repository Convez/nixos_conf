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
    
    # Handle fish as default shell edge case
    # Fish is not POSIX compliant, which can cause issues
    # In this case, we will set bash as default shell
    # And have bash spawn fish
    users.defaultUserShell = if cfg.defaultShell == pkgs.fish then pkgs.bash else cfg.defaultShell;
    programs.bash = mkIf (cfg.defaultShell == pkgs.fish) {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    }; 
    programs = {
      direnv.enable = cfg.enableDirEnv;
      # Enable all supported shells (bash is enabled by default)
      fish.enable = true;
      zsh.enable = true;
    };
    environment.variables = { TERM = cfg.defaultTerminal.meta.mainProgram; };
    
  };
}
