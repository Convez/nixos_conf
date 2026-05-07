function __fish_copy_or_interrupt
    set -l selection (commandline --current-selection | string collect)
    if test -n "$selection"
        fish_clipboard_copy
        commandline -f end-selection repaint
    else
        commandline -f cancel-commandline repaint
    end
end
