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
    echo "arg: <<${1}>>" 1>&2
    kitty_locations=(vsplit before hsplit after last neighbor first)
    kitty_split_types=(window tab primary clipboard os-window background overlay)

    case "${kitty_locations[@]}" in
      *"${1}"*)
        split_arg=$1
        shift
        ;;
    esac

    case "${kitty_split_types[@]}" in
      *"${1}"*)
        type_arg=$1
        shift
        ;;
    esac

    echo "split_arg: <<${split_arg:-$kak_opt_kitty_split_default_location}>>" 1>&2
    echo "type_arg: <<${type_arg:-$kak_opt_kitty_split_default_type}>>" 1>&2
    echo "shifted: <<${1}>>" 1>&2
    kitty @ launch --no-response --type="${type_arg:-$kak_opt_kitty_split_default_type}" --cwd="$PWD" --location="${split_arg:-$kak_opt_kitty_split_default_location}" "${@}"
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

define-command new-vertical-split %{
    kitty-split-vertical kak -c "%val{session}"
}
define-command new-horizontal-split %{
    kitty-split-horizontal kak -c "%val{session}"
}

alias global vsplit new-vertical-split
alias global hsplit new-horizontal-split

require-module kitty

unalias global terminal kitty
alias global terminal kitty-split
alias global focus kitty-focus
