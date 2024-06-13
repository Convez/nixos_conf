{ config, languages,... }:
let
 cfg = config.convez.coding;
in
{

  programs.vscode = {
    enable = cfg.ides.code;
    mutableExtensionsDir=true;
    extensions = languages.codeExtensions;
    userSettings = {
      "editor.fontFamily"= "MesloLGS NF";
      "terminal.integrated.persistentSessionReviveProcess"= "never";
      "terminal.integrated.defaultProfile.linux"= "zsh";
      "terminal.integrated.fontFamily"="MesloLGS NF";
    } //
    languages.codeSettings;
  };
}