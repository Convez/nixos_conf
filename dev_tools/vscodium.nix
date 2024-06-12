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
      "editor.fontFamily"= "MesloLGS NF Regular";
      "terminal.integrated.persistentSessionReviveProcess"= "never";
    } //
    languages.codeSettings;
  };
}