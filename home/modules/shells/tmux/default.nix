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
      terminal = "xterm-256color";
      clock24 = true;
      keyMode = "vi";
      customPaneNavigationAndResize = true;
      mouse = true;

      plugins = with pkgs.tmuxPlugins; [
        dracula
      ];
      extraConfig = ''

        set -ga terminal-overrides ",*256col*:Tc"
        set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        set-environment -g COLORTERM "truecolor"

        bind-key -r -T root C-h select-window -t :-
        bind-key -r -T root C-l select-window -t :+

      '';
    };
        #run-shell ${pkgs.tmuxPlugins.dracula}/share/tmux-plugins/dracula/dracula.tmux
  };
}

