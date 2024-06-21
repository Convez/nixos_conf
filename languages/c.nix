{config, pkgs, lib, ...}:
let 
  convez = config.convez;
  enableC = convez.coding.languages.c;
in{
  packages = lib.optionals enableC (with pkgs;[
    clang-tools
    cmake
    codespell
    conan
    cppcheck
    doxygen
    gtest
    lcov
    vcpkg-tool
    ccls
    gcc
  ]);
  codeExtensions = lib.optionals enableC (with pkgs.vscode-extensions;[
    ms-vscode.cpptools
  ]);

  codeSettings = lib.optionalAttrs enableC {
  };
  
  vimPlugins = lib.optionals enableC(with pkgs.vimPlugins;[
    coc-clangd
  ]);
  
  vimSettings = ''
  '';
}