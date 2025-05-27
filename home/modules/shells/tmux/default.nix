{pkgs, config, lib, ...}:
let
  cfg = config.myHome.shells.tmux;
in
with lib;
{
  options.myHome.shells.tmux = {
    enable = mkEnableOption "Enable tmux configuration";
  };
  config = {
    home.file.".tmux.conf".source = ./config/tmux.conf;
    programs.tmux = {
      enable = cfg.enable;
      terminal = config.myHome.shells.defaultTerm.meta.mainProgram;
      clock24 = true;
      keyMode = "vi";
      customPaneNavigationAndResize = true;
      mouse = true;

      plugins = with pkgs.tmuxPlugins; [
        dracula
      ];
      extraConfig = ''

				set-option -g pane-border-style fg=default
				set-option -g window-style 'fg=default,bg=default'
				set-option -g window-active-style 'fg=default,bg=default'
        set -ga terminal-overrides ",*256col*:Tc"
        set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        set-environment -g COLORTERM "truecolor"

        bind-key -r -T root M-h select-window -t :-
        bind-key -r -T root M-l select-window -t :+
				unbind C-v
      '';
    };
  };
}

