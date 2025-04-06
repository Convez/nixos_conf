{config, ...}:
let
  awesomeConfig = ./config/rc.lua;
in
{
  home.file.".config/awesome/rc.lua".source = awesomeConfig;
}
