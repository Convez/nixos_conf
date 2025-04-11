{ config, ... }:
let
in {
  home.file.".xinitrc".text = "awesome";
  home.file.".config/awesome".source =
    config.lib.file.mkOutOfStoreSymlink ./config;
}
