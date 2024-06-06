{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions;[
      jnoortheen.nix-ide
    ];
    userSettings = {
      "nix.enableLanguageServer"= true;
      "nix.formatterPath"= "nixpkgs-fmt";
      "nix.serverPath"= "nixd";
    };
  };
}