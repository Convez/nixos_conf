{ config, pkgs, lib, ... }:
let
  nixConf = import ./nix.nix { inherit config pkgs lib; };
  cloudConf = import ./cloud.nix { inherit config pkgs lib; };
  javaConf = import ./java.nix { inherit config pkgs lib; };
  tsConf = import ./typescript.nix { inherit config pkgs lib; };
  rustConf = import ./rust.nix { inherit config pkgs lib; };
  cConf = import ./c.nix { inherit config pkgs lib; };
  c_sharpConf = import ./c_sharp.nix { inherit config pkgs lib; };
in {

  packages = [ pkgs.meslo-lgs-nf pkgs.grc pkgs.gcc ] ++ nixConf.packages
    ++ cloudConf.packages ++ javaConf.packages ++ tsConf.packages
    ++ rustConf.packages ++ cConf.packages ++ c_sharpConf.packages;
  codeExtensions = nixConf.codeExtensions ++ cloudConf.codeExtensions
    ++ javaConf.codeExtensions ++ tsConf.codeExtensions
    ++ rustConf.codeExtensions ++ cConf.codeExtensions ++ c_sharpConf.packages;
  codeSettings = nixConf.codeSettings // cloudConf.codeSettings
    // javaConf.codeSettings // tsConf.codeSettings // rustConf.codeSettings
    // cConf.codeSettings // c_sharpConf.codeSettings;

  vimPlugins = nixConf.vimPlugins ++ cloudConf.vimPlugins ++ javaConf.vimPlugins
    ++ tsConf.vimPlugins ++ rustConf.vimPlugins ++ cConf.vimPlugins
    ++ c_sharpConf.vimPlugins;

  vimSettings = lib.strings.concatStringsSep "\n" [
    nixConf.vimSettings
    cloudConf.vimSettings
    javaConf.vimSettings
    tsConf.vimSettings
    rustConf.vimSettings
    cConf.vimSettings
    c_sharpConf.vimSettings
  ];
}
