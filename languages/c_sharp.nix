{ config, pkgs, lib, ... }:
let
  convez = config.convez;
in
{
  packages = lib.optionals convez.coding.languages.c_sharp (with pkgs;[
    dotnet-sdk_8
    omnisharp-roslyn
    mono
  ]);
  codeExtensions = lib.optionals convez.coding.languages.c_sharp (with pkgs.vscode-extensions;[
    ms-dotnettools.csdevkit
  ]);

  codeSettings = lib.optionalAttrs convez.coding.languages.c_sharp {
  };

  vimPlugins = lib.optionals convez.coding.languages.c_sharp(with pkgs.vimPlugins;[
      omnisharp-extended-lsp-nvim
  ]);
  
  vimSettings = ''
  '';
}