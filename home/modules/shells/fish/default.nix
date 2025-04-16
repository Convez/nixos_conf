{pkgs, config, lib, ...}:
let
in
with lib;
{
options.myHome.shells.fish = {
  enable = mkEnableOption "Enable fish shell configuration";
};
}
