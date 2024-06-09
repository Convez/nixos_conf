{config, pkgs, lib, ... }:
let
  nixConf = import ./nix.nix {inherit config pkgs lib;};
  cloudConf = import ./cloud.nix {inherit config pkgs lib;};
  javaConf = import ./java.nix {inherit config pkgs lib;};
in 
{

  packages = nixConf.packages ++ 
    cloudConf.packages ++
    javaConf.packages
  ;
  codeExtensions = nixConf.codeExtensions ++
    cloudConf.codeExtensions ++
    javaConf.codeExtensions
    ;
  codeSettings = nixConf.codeSettings //
    cloudConf.codeSettings //
    javaConf.codeSettings
  ;
  
}