{config,lib, ...}:
let
  awesomeConfig = ./config/rc.lua;
  awesomeTheme = ./config/theme.lua;
  configFiles = builtins.readDir ./config;
  filesMap = lib.mapAttrs(f: t: {"${builtins.toString f}".source = ./config/${f};}) configFiles;
in
{
  home.file.".config/awesome".source = config.lib.file.mkOutOfStoreSymlink ./config;
  # home.file.".config/awesome/rc.lua".source = awesomeConfig;
  # home.file.".config/awesome/theme.lua".source = awesomeTheme;
}
