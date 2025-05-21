{pkgs, config, lib, ...}:
let
cfg = config.myHome.shells.fish;
hasTmux = config.myHome.shells.tmux.enable;
useTmux = if hasTmux then ''
	if not set -q TMUX
			set -g TMUX tmux new-session -d -s base
			eval $TMUX
			exec tmux attach-session -d -t base
	end		
'' else "";
in
with lib;
{
options.myHome.shells.fish = {
  enable = mkEnableOption "Enable fish shell configuration";
};
config={
	home.file.".config/fish/functions/fish_prompt.fish".source = ./config/prompt.fish;
	programs.fish = mkIf cfg.enable {
		enable = cfg.enable;
		interactiveShellInit = ''
			${useTmux}
			set fish_greeting
			set fish_color_command yellow
		'';
	};
};
}
