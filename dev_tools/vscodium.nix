{ config, pkgs, convez,... }:
let
 cfg = config.convez.coding;
in
{

  programs.vscode = {
    enable = cfg.enable;
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