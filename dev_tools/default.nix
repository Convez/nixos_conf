{config, pkgs,languages, ... }:
let
  neovim = import       ./neovim.nix {inherit config pkgs languages;};
  vscodium = import ./vscodium.nix  {inherit config pkgs languages;}; 
in
{
  imports = 
    [
      ./git.nix
      neovim
      vscodium
    ];

}