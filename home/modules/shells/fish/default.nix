{pkgs, config, lib, ...}:
let
cfg = config.myHome.shells.fish;
hasTmux = config.myHome.shells.tmux.enable;
useTmux = if hasTmux then ''
  if not status is-login
    if not set -q TMUX
        set -g TMUX tmux new-session -d -s base
        eval $TMUX
        exec tmux  attach-session -d -t base
    end   
  end
'' else "";
manualDirenv = if config.myHome.shells.manualDirenv then ''
direnv hook fish | source
'' else "";
in
with lib;
{
options.myHome.shells.fish = {
  enable = mkEnableOption "Enable fish shell configuration";
};
config={
  home.file.".config/fish/functions/fish_prompt.fish".source = ./config/prompt.fish;
  home.file.".config/fish/functions/__fish_copy_or_interrupt.fish".source = ./config/fish_copy_or_interrupt.fish;
  home.file.".config/fish/functions/__fish_cut_selection.fish".source = ./config/fish_cut_selection.fish;
  programs.fish = mkIf cfg.enable {
    enable = cfg.enable;
    interactiveShellInit = ''
      ${useTmux}
      ${manualDirenv}
      set fish_greeting
      set fish_color_command yellow
      if not set -q NOTIF_STARTED
        begin
          hyprnotify &
        end &> /dev/null
        set -g NOTIF_STARTED
      end

      # Shift+Left/Right -> select character by character
      bind \e'[1;2D' begin-selection backward-char
      bind \e'[1;2C' begin-selection forward-char

      # Ctrl+Shift+Left/Right -> select word by word
      bind \e'[1;6D' begin-selection backward-word
      bind \e'[1;6C' begin-selection forward-word

      # Ctrl+C -> copy selection to clipboard (or interrupt if no selection)
      bind \cc '__fish_copy_or_interrupt'
      # Ctrl+X -> cut selection to clipboard
      bind \cx '__fish_cut_selection'
    '';
  };
};
}
