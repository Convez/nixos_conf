{ config, pkgs, lib, stateVersion, user, ... }:
let
  settings = import ../../settings {inherit pkgs lib;};
  languages = import ../../languages {inherit config pkgs lib;};
  dev_tools = import ../../dev_tools {inherit config pkgs lib languages;};
  languagePrograms = import ../../languages/programs.nix {inherit config pkgs lib;};
  shellConf = import ../shell {inherit config pkgs;};
  zscalerCert = "af.zscaler.crt";
in
{

  convez.coding = {
    enable = true;
    ides = {
      vim = true;
    };
    languages = {
      java = {
        enable =  true;
        version = pkgs.jdk17;
      };
      nix = true;
      cloud = true;
      typescript = true;
      rust = true;
      c = true;
      c_sharp = true;
    };
    maven.settings = "af";
  };
  imports = [
    settings
    dev_tools
    languagePrograms
    shellConf
  ];

  # Home manager user settings
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "${stateVersion}";
  programs.home-manager.enable = true;

  # Allow unfree packages
  nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
  };

  # Define home packages to install
  home.packages = (with pkgs;[
    # retroarchFull
  ]) ++ languages.packages;
  home.file.".minikube/certs/zscaler.cert".source = ../../hosts/certificates/${zscalerCert};
}
