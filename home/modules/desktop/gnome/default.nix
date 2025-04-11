{ pkgs, lib, ... }:
let extensions = pkgs.gnomeExtensions;
in {

  packages = with extensions; [ no-titlebar-when-maximized ];

  dconf = with lib.gvariant; {
    "org/gnome/shell".disabled-extensions = [ ];
    "org/gnome/shell".enabled-extensions =
      [ "no-titlebar-when-maximized@alec.ninja" ];
  };

}
