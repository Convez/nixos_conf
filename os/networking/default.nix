{ pkgs, hostname, config, lib, ... }:
let cfg = config.myConf.networking;

in with lib; {
  options.myConf.networking = {
    ssh = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable SSH server";
      };
      keyOnly = mkOption {
        type = types.bool;
        default = false;
        description = "Enable SSH key authentication only";
      };
    };
    printing = mkOption {
      type = types.bool;
      default = false;
      description = "Enable CUPS to print documents";
    };
  };
  config = {
    # Enable CUPS to print documents.
    services.printing.enable = cfg.printing;

    # Enable OpenSSH services
    services.openssh = {
      enable = cfg.ssh.enable;
      ports = [ 2222 ];
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = !cfg.ssh.keyOnly;
      };
    };
    networking.hostName = hostname;
    networking.networkmanager.enable =
      lib.mkForce true; # Easiest to use and most distros use this by default.
    environment.systemPackages = with pkgs; [ wget curl openssl ];
    programs.firefox = {
      enable = true;
      package = pkgs.librewolf;
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        Preferences = {
          "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
          "cookiebanners.service.mode" = 2; # Block cookie banners
          "privacy.donottrackheader.enabled" = true;
          "privacy.fingerprintingProtection" = true;
          "privacy.resistFingerprinting" = true;
          "privacy.trackingprotection.emailtracking.enabled" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.fingerprinting.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
        };
        ExtensionSettings = {
          "jid1-ZAdIEUB7XOzOJw@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
            installation_mode = "force_installed";
          };
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4450700/proton_pass-1.29.9.xpi";
            installation_mode = "force_installed";
          };
          "addon@darkreader.org.xpi" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4439735/darkreader-4.9.103.xpi";
            installation_mode = "force_installed";
          };
        };
      };
    };
  };
}
