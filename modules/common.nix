{ pkgs, stateVersion, ... }:
{
  # Define common packages to install
  environment.systemPackages = with pkgs; [
    wget
    curl
    openssl
    powershell
  ];
  # Set your time zone.
  time.timeZone = "Europe/Rome";
  system.stateVersion = stateVersion;
  # Install firefox.
  programs.firefox.enable = true;

  # Enable Flakes
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  # Enable dconf
  programs.dconf.enable = true;
}
