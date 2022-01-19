# Ensure we don't load built-in kitty module
set-option global windowing_modules

declare-option str kitty_split_default_location "last"
declare-option str kitty_split_default_type "window"

define-command kitty-split -params .. -shell-completion -docstring '
kitty-split [location] [type] [<arguments>]: create a new terminal window as a kitty split
Accepts --horizontal or --vertical for the location of the split
Any extra arguments will be passed to "kitty @ launch"' \
%{
  nop %sh{
    if [ "$1" = "vsplit" ] \
        || [ "$1" = "before" ] \
        || [ "$1" = "hsplit" ] \
        || [ "$1" = "after" ] \
        || [ "$1" = "last" ] \
        || [ "$1" = "neighbor" ] \
        || [ "$1" = "first" ]; \
    then
        split_arg=$1
        shift
    fi

    if [ "$1" = "window" ] \
        || [ "$1" = "tab" ] \
        || [ "$1" = "primary" ] \
        || [ "$1" = "clipboard" ] \
        || [ "$1" = "os-window" ] \
        || [ "$1" = "background" ] \
        || [ "$1" = "overlay" ]; \
    then
        type_arg=$1
        shift
    fi

    kitty @ --to=$KITTY_LISTEN_ON launch --no-response --type="${type_arg:-$kak_opt_kitty_split_default_type}" --cwd="$PWD" --location="${split_arg:-$kak_opt_kitty_split_default_location}" "${@}"
  }
}

define-command kitty-split-horizontal -params .. -shell-completion -docstring '
kitty-split-horizontal [<arguments>]: create a new terminal window above or below
the current window.
Any extra arguments will be passed to "kitty @ launch"' \
%{
    kitty-split hsplit %arg{@}
}

define-command kitty-split-vertical -params .. -shell-completion -docstring '
kitty-split-vertical [<arguments>]: create a new terminal window to the left or right of
the current window.
Any extra arguments will be passed to "kitty @ launch"' \
%{
    kitty-split vsplit %arg{@}
}

define-command kitty-overlay -params .. -shell-completion -docstring '
kitty-overlay [<arguments>]: create a new terminal window on top of the current window.
Any extra arguments will be passed to "kitty @ launch"' \
%{
    kitty-split overlay %arg{@}
}

define-command new-vertical-split -params .. %{
    kitty-split-vertical kak -c "%val{session}" -e "%arg{@}"
}
define-command new-horizontal-split -params .. %{
    kitty-split-horizontal kak -c "%val{session}" -e "%arg{@}"
}

alias global vsplit new-vertical-split
alias global hsplit new-horizontal-split

require-module kitty

unalias global terminal kitty
alias global terminal kitty-split
alias global focus kitty-focus
