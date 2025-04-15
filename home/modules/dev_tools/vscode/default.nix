{ pkgs, config, lib, ... }:
let 
  cfg = config.myHome.dev.vscode;
  defaultExtensions = with pkgs.vscode-extensions; [
    asvetliakov.vscode-neovim 
  ];
  totalExtensions = defaultExtensions ++ cfg.extraExtensions;
  defaultSettings = {
    "editor.fontFamily" = "MesloLGS NF";
    "terminal.integrated.persistentSessionReviveProcess" = "never";
    "terminal.integrated.defaultProfile.linux" = "zsh";
    "terminal.integrated.fontFamily" = "MesloLGS NF";
    "runtimeExecutable" = "/home/convez/.nix-profile/bin/node";
  }; 
  totalSettings = defaultSettings // cfg.extraSettings;
in 
with lib;{
  options = {
    myHome.dev.vscode = {
      enable = mkEnableOption "Install vscode";
      extraExtensions = mkOption {
        type = types.listOf types.package;
        default = [];
        description = "Extra vscode extensions to install. vscode-neovim is always installed.";
      };
      extraSettings = mkOption {
        type = types.attrsOf types.str;
        default = {};
        description = "Extra vscode settings to apply. These settings are applied to vscode user settings.";
      };
    };
  };
  config = {
    programs.vscode = {
      enable = cfg.enable;
      mutableExtensionsDir = true;
      profiles.default = {
        extensions = totalExtensions;
        userSettings = totalSettings;
      };
    };
  };
}
