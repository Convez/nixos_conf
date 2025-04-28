{ config, pkgs, lib, stateVersion, user, ... }:
let
  modules = import ../modules;
  # settings = import ../../settings { inherit pkgs lib; };
  # languages = import ../../languages { inherit config pkgs lib; };
  # dev_tools = import ../../dev_tools { inherit config pkgs lib languages; };
  # languagePrograms =
    # import ../../languages/programs.nix { inherit config pkgs lib; };
  # shellConf = import ../shell { inherit config pkgs; };
  # zscalerCert = "af.zscaler.crt";
in {
  imports = [ modules ];

  config = {
    myHome = {
      git = {
        userName = "Convez";
        userEmail = "convezione@proton.me";
      };
      dev = {
        nvim.enable = true;
      };
      shells = {
        zsh = {
          enable = true;
          enableAutocomplete = true;
        };
        fish = {
          enable = true;
        };
        tmux = {
          enable = true;
        };
      };
      cli = {
        enableKubeTools = true;
        enableTerraform = true;
        enableAzCli = true;
        enableBuildpack = true;
      };
    };
    # Define home packages to install
    # home.packages = (with pkgs;
      # [
        # retroarchFull
      # ]) ++ languages.packages;
    # home.file.".minikube/certs/zscaler.cert".source =
      # ../../hosts/certificates/${zscalerCert};
  };
  # convez.coding = {
  #   enable = true;
  #   ides = { vim = true; };
  #   languages = {
  #     java = {
  #       enable = true;
  #       version = pkgs.jdk17;
  #     };
  #     nix = true;
  #     cloud = true;
  #     typescript = true;
  #     rust = true;
  #     c = false;
  #     c_sharp = false;
  #   };
  #   maven.settings = "af";
  # };
}
