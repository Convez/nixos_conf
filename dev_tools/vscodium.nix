{ config, pkgs, languages,... }:
let
 cfg = config.convez.coding;
in
{

  programs.vscode = {
    enable = cfg.ides.code;
    extensions = languages.codeExtensions;
  };
}