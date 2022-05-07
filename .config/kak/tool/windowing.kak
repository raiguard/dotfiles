define-command kitty-overlay -params .. -shell-completion -docstring '
kitty-overlay [<arguments>]: create a new terminal window on top of the current window.
Any extra arguments will be passed to "kitty @ launch"' \
%{
    set global kitty_window_type overlay
    terminal %arg{@}
    set global kitty_window_type window
}
alias global terminal-overlay kitty-overlay

define-command terminal-os -params .. -shell-completion -docstring '
terminal-os [<arguments>]: create a new terminal window using the window manager.
Any extra arguments will be passed to "kitty @ launch"' \
%{
    set global kitty_window_type os-window
    terminal %arg{@}
    set global kitty_window_type window
}

define-command terminal-os-floating -params .. -shell-completion -docstring '
terminal-os-floating [<arguments>]: create a new terminal window using the window manager.
The created window will be floated in the center of the screen.
Any extra arguments will be passed to "kitty @ launch"' \
%{
    set global kitty_window_type os-window
    terminal --os-window-title=floating %arg{@}
    set global kitty_window_type window
}

define-command new-os %{
    kitty-os kak -c %val{session}
}
