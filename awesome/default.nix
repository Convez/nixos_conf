{config, ...}:
let
  awesomeConfig = ./config/rc.lua;
  awesomeTheme = ./config/theme.lua;
in
{
  home.file.".config/awesome/rc.lua".source = awesomeConfig;
  home.file.".config/awesome/theme.lua".source = awesomeTheme;
}
