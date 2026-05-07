function __fish_cut_selection
    set -l selection (commandline --current-selection | string collect)
    if test -n "$selection"
        fish_clipboard_copy
        commandline -f kill-selection repaint
    end
end
