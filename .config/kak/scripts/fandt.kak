# source: https://gitlab.com/listentolist/kakoune-fandt

provide-module fandt %§

declare-option str fandt_jump ""
declare-option bool fandt_show_autoinfo false
declare-option -hidden str fandt_autoinfo %opt{autoinfo}
declare-option -hidden str fandt_char ""

declare-user-mode fandt

# Commands

define-command -override -params 1..2 fandt %{
  set-option window fandt_autoinfo %opt{autoinfo}
  evaluate-commands %sh{
    if ! "$kak_opt_fandt_show_autoinfo"; then
      echo "set-option window autoinfo ''"
    fi
  }
  on-key %{
    hook -once -group fandt window RawKey .* %{
      hook -group fandt window RawKey .* %{
        evaluate-commands %sh{
          case "$kak_hook_param" in
            f|F|t|T|"<a-f>"|"<a-F>"|"<a-t>"|"<a-T>") ;;
            *) echo "set-option window autoinfo '$kak_opt_fandt_autoinfo'"
               echo "remove-hooks window fandt"
               echo "execute-keys -with-hooks -with-maps <esc> $kak_hook_param" ;;
          esac
        }
      }
    }
    set-option window fandt_char %val{key}
    execute-keys %val{count} %arg{1} %val{key} %arg{2}
    enter-user-mode -lock fandt
  }
}

define-command -hidden -override fandt-f %{ fandt f %opt{fandt_jump} }
define-command -hidden -override fandt-F %{ fandt F }
define-command -hidden -override fandt-a-f %{ fandt <a-f> %opt{fandt_jump} }
define-command -hidden -override fandt-a-F %{ fandt <a-F> }
define-command -hidden -override fandt-t %{ fandt t %opt{fandt_jump} }
define-command -hidden -override fandt-T %{ fandt T }
define-command -hidden -override fandt-a-t %{ fandt <a-t> %opt{fandt_jump} }
define-command -hidden -override fandt-a-T %{ fandt <a-T> }

# user mode commands

define-command -hidden -override fandt-mode-f %{
  execute-keys "<esc>f%opt{fandt_char}%opt{fandt_jump}"
}

define-command -hidden -override fandt-mode-F %{
  execute-keys "<esc>F%opt{fandt_char}"
}

define-command -hidden -override fandt-mode-a-f %{
  execute-keys "<esc><a-f>%opt{fandt_char}%opt{fandt_jump}"
}

define-command -hidden -override fandt-mode-a-F %{
  execute-keys "<esc><a-F>%opt{fandt_char}"
}

define-command -hidden -override fandt-mode-t %{
  execute-keys "<esc>lt%opt{fandt_char}%opt{fandt_jump}"
}

define-command -hidden -override fandt-mode-T %{
  execute-keys "<esc>LT%opt{fandt_char}"
}

define-command -hidden -override fandt-mode-a-t %{
  execute-keys "<esc>h<a-t>%opt{fandt_char}%opt{fandt_jump}"
}

define-command -hidden -override fandt-mode-a-T %{
  execute-keys "<esc>H<a-T>%opt{fandt_char}"
}

# Mappings

map global fandt f ": fandt-mode-f<ret>" \
  -docstring "jump/select to next occurence"
map global fandt <a-f> ": fandt-mode-a-f<ret>" \
  -docstring "jump/select to next occurence in reverse direction"
map global fandt F ": fandt-mode-F<ret>" \
  -docstring "extend selection to next occurence"
map global fandt <a-F> ": fandt-mode-a-F<ret>" \
  -docstring "extend selection to next occurence in reverse direction"
map global fandt t ": fandt-mode-t<ret>" \
  -docstring "jump/select until next occurence"
map global fandt <a-t> ": fandt-mode-a-t<ret>" \
  -docstring "jump/select until next occurence in reverse direction"
map global fandt T ": fandt-mode-T<ret>" \
  -docstring "extend selection until next occurence"
map global fandt <a-T> ": fandt-mode-a-T<ret>" \
  -docstring "extend selection until next occurence in reverse direction"

map global normal f ": fandt-f<ret>"
map global normal F ": fandt-F<ret>"
map global normal <a-f> ": fandt-a-f<ret>"
map global normal <a-F> ": fandt-a-F<ret>"
map global normal t ": fandt-t<ret>"
map global normal T ": fandt-T<ret>"
map global normal <a-t> ": fandt-a-t<ret>"
map global normal <a-T> ": fandt-a-T<ret>"

§

