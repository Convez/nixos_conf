{ config, languages,... }:
let
 cfg = config.convez.coding;
in
{

  programs.vscode = {
    enable = cfg.ides.code;
    mutableExtensionsDir=true;
    extensions = languages.codeExtensions;
    userSettings = languages.codeSettings;
  };
}