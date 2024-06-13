{ config, pkgs, lib, ... }:
let
  convez = config.convez;
in
{

  packages = lib.optionals convez.coding.languages.rust (with pkgs;[
    cargo
    rustc
  ]);
  codeExtensions = lib.optionals convez.coding.languages.rust (with pkgs.vscode-extensions;[
    rust-lang.rust-analyzer
  ]);

  codeSettings = lib.optionalAttrs convez.coding.languages.rust {
  };
  
  vimPlugins = lib.optionals convez.coding.languages.rust(with pkgs.vimPlugins;[
    coc-rust-analyzer
    coc-rls
  ]);
  
  vimSettings = ''
  '';
}
