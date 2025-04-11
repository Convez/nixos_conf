{ config, lib, ... }:
let cfg = config.myConf.localization;
in with lib; {

  options.myConf.localization = {
    lang = mkOption {
      type = types.str;
      default = "it_IT.UTF-8";
      description = "Language to set for the system.";
    };
    timeZone = mkOption {
      type = types.str;
      default = "Europe/Rome";
      description = "Time zone to set for the system.";
    };
  };
  config = {
    # Set your time zone.
    time.timeZone = cfg.timeZone;

    # Select internationalisation properties.
    i18n.defaultLocale = cfg.lang;

    i18n.extraLocaleSettings = {
      LC_ADDRESS = cfg.lang;
      LC_IDENTIFICATION = cfg.lang;
      LC_MEASUREMENT = cfg.lang;
      LC_MONETARY = cfg.lang;
      LC_NAME = cfg.lang;
      LC_NUMERIC = cfg.lang;
      LC_PAPER = cfg.lang;
      LC_TELEPHONE = cfg.lang;
      LC_TIME = cfg.lang;
    };

    # TODO: Move keyboard config to own file / add keyboard configuration
    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "gb";
      variant = "intl";
    };

    console = {
      font = "Lat2-Terminus16";
      keyMap = "uk";
      useXkbConfig = false; # use xkb.options in tty.
    };
  };
}
