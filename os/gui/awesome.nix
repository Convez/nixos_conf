{ pkgs, config, lib, ... }:
with lib;
let
  guiCfg = config.myConf.gui;
  cfg = guiCfg.awesome;
  defaultModules = with pkgs.luajitPackages; [ luarocks luadbi-mysql lgi ];
  toInstall = cfg.luaExtraModules ++ defaultModules;
in {
  options.myConf.gui.awesome = {
    enable = mkEnableOption "Enable the awesome window manager";
    luaExtraModules = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = ''
        List of extra Lua modules to be installed in the awesome window manager.
        This is a list of luajitPackages.
        The following packages are installed by default:
         - luarocks
         - luadbi-mysql
         - lgi
      '';
    };
  };
  config = mkIf cfg.enable {
    assertions = [ ];

    services = {
      xserver = {
        windowManager.awesome = {
          enable = true;
          luaModules = toInstall;
        };
        displayManager = { startx.enable = true; };
      };
    };
  };
}
