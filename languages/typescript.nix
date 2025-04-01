{ config, pkgs, lib, ... }:
let
  inherit (config) convez;
in
{

  packages = lib.optionals convez.coding.languages.typescript (with pkgs;[
    typescript
    nodejs
  ]);
  codeExtensions = lib.optionals convez.coding.languages.typescript (with pkgs.vscode-extensions;[
    angular.ng-template
  ]);

  codeSettings = lib.optionalAttrs convez.coding.languages.typescript {
  };
  
  vimPlugins = lib.optionals convez.coding.languages.typescript(with pkgs.vimPlugins;[
    typescript-tools-nvim
  ]);
  
  vimSettings = ''
  '';
}
