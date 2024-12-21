{ pkgs, ... }:
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

  # Allow unfree packages
  nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
  };

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
