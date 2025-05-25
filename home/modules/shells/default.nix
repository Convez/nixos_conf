{pkgs, config, lib, ...}:
let
  zsh = import ./zsh;
  fish = import ./fish;
  tmux = import ./tmux;
  cfg = config.myHome.shells;

  toInstall = [
		cfg.defaultTerm
		];
in
with lib;
{
  imports = [zsh fish tmux];
  options.myHome.shells = {
   	defaultTerm = mkOption{
			type = types.package;
			default = pkgs.xterm;
			description = "Default terminal. This sets TERM env variable and is reused to configure desktop envs (ex. Hyprland, AwesomeWM)";
		};
  };
  config = {
    home.packages = toInstall;
		home.sessionVariables.TERM = cfg.defaultTerm.meta.mainProgram;
  };
}
