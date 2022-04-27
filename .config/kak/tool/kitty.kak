# Extends the built-in kitty support with some new commands

define-command kitty-overlay -params .. -shell-completion -docstring '
kitty-overlay [<arguments>]: create a new terminal window on top of the current window.
Any extra arguments will be passed to "kitty @ launch"' \
%{
    set global kitty_window_type overlay
    terminal %arg{@}
    set global kitty_window_type window
}

define-command kitty-os -params .. -shell-completion -docstring '
kitty-os [<arguments>]: create a new terminal window using the window manager.
Any extra arguments will be passed to "kitty @ launch"' \
%{
    set global kitty_window_type os-window
    terminal %arg{@}
    set global kitty_window_type window
}

define-command new-os %{
    kitty-os kak -c %val{session}
}
