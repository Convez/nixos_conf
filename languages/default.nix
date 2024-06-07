{config, pkgs, lib, ... }:
let
  nixConf = import ./nix.nix {inherit config pkgs lib;};
  inherit (lib) mergeAttrsList;
in 
{

  packages = [] ++ nixConf.packages;
  codeExtensions = [] ++ nixConf.codeExtensions;
  codeSettings = mergeAttrsList [
    nixConf.codeSettings
  ];
  
}