{config, pkgs, lib, ... }:
let
  nixConf = import ./nix.nix {inherit config pkgs lib;};
  cloudConf = import ./cloud.nix {inherit config pkgs lib;};
  javaConf = import ./java.nix {inherit config pkgs lib;};
  tsConf = import ./typescript.nix {inherit config pkgs lib;};
  rustConf = import ./rust.nix {inherit config pkgs lib;};
in 
{

  packages = [pkgs.meslo-lgs-nf pkgs.grc] ++ nixConf.packages ++ 
    cloudConf.packages ++
    javaConf.packages ++
    tsConf.packages ++
    rustConf.packages
  ;
  codeExtensions = nixConf.codeExtensions ++
    cloudConf.codeExtensions ++
    javaConf.codeExtensions ++
    tsConf.codeExtensions ++
    rustConf.codeExtensions
  ;
  codeSettings = nixConf.codeSettings //
    cloudConf.codeSettings //
    javaConf.codeSettings //
    tsConf.codeSettings //
    rustConf.codeSettings
  ;

  vimPlugins = nixConf.vimPlugins ++
    cloudConf.vimPlugins ++
    javaConf.vimPlugins ++
    tsConf.vimPlugins ++
    rustConf.vimPlugins
  ;
  
  vimSettings = lib.strings.concatStringsSep "\n" [
    nixConf.vimSettings
    cloudConf.vimSettings
    javaConf.vimSettings
    tsConf.vimSettings
    rustConf.vimSettings
  ];
}