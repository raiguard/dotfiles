hook global ModuleLoaded kitty %{
    set-option global kitty_window_type os-window

    define-command kitty-overlay -params .. -shell-completion -docstring '
    kitty-overlay [<arguments>]: create a new terminal window on top of the current window.
    Any extra arguments will be passed to "kitty @ launch"' \
    %{
        set global kitty_window_type overlay
        terminal %arg{@}
        set global kitty_window_type os-window
    }
    alias global terminal-overlay kitty-overlay

    define-command kitty-popup -params .. -shell-completion -docstring '
    kitty-popup [<arguments>]: create a new terminal window using the window manager.
    The created window will be floated in the center of the screen.
    Any extra arguments will be passed to "kitty @ launch"' \
    %{
        terminal --os-window-title=floating %arg{@}
    }
    alias global terminal-popup kitty-popup
    alias global popup kitty-popup
}
