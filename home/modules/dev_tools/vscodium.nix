{ pkgs, config, languages, ... }:
let cfg = config.convez.coding;
in {
  programs.vscode = {
    enable = cfg.ides.code;
    mutableExtensionsDir = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions;
        [ asvetliakov.vscode-neovim ] ++ languages.codeExtensions;
      userSettings = {
        "editor.fontFamily" = "MesloLGS NF";
        "terminal.integrated.persistentSessionReviveProcess" = "never";
        "terminal.integrated.defaultProfile.linux" = "zsh";
        "terminal.integrated.fontFamily" = "MesloLGS NF";
        "runtimeExecutable" = "/home/convez/.nix-profile/bin/node";
      } // languages.codeSettings;
    };
  };
}
