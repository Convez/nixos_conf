{ config, languages,... }:
let
 cfg = config.convez.coding;
in
{
  programs.vscode = {
    enable = cfg.ides.code;
    mutableExtensionsDir=true;
    profiles.default = {
      extensions = languages.codeExtensions;
      userSettings = {
        "editor.fontFamily"= "MesloLGS NF";
        "terminal.integrated.persistentSessionReviveProcess"= "never";
        "terminal.integrated.defaultProfile.linux"= "zsh";
        "terminal.integrated.fontFamily"="MesloLGS NF";
        "runtimeExecutable"= "/home/convez/.nix-profile/bin/node";
      } //
      languages.codeSettings;
    };
  };
}
