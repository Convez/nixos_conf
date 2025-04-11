{ config, pkgs, lib, ... }:
let inherit (config) convez;
in {

  packages = lib.optionals convez.coding.languages.rust (with pkgs; [
    rust-analyzer
    rustc
    cargo
    rustPackages.rustPlatform.rustcSrc
    rustc.llvmPackages.llvm
    pkg-config
    openssl.dev
    libpqxx
  ]);
  codeExtensions = lib.optionals convez.coding.languages.rust
    (with pkgs.vscode-extensions; [ rust-lang.rust-analyzer ]);

  codeSettings = lib.optionalAttrs convez.coding.languages.rust { };

  vimPlugins = lib.optionals convez.coding.languages.rust
    (with pkgs.vimPlugins; [ coc-rust-analyzer ]);

  vimSettings = "";
}
