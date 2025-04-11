{ pkgs, config, lib, ... }:
let
in with lib; { imports = [ ./awesome ./gnome ./kde ]; }
