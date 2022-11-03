define-command edit-kakrc %{ e ~/.config/kak/kakrc }

define-command delete-all-buffers -docstring "delete all buffers" %{
  evaluate-commands %sh{
    eval "set -- $kak_quoted_buflist"
    while [ $# -gt 0 ]; do
        echo "try %{ delete-buffer '$1' } catch %{ echo -markup '{Error}Not all buffers were closed' }"
        shift
    done
  }
}

define-command delete-all-buffers-force -docstring "delete all buffers" %{
  evaluate-commands %sh{
    eval "set -- $kak_quoted_buflist"
    while [ $# -gt 0 ]; do
        echo "try %{ delete-buffer! '$1' } catch %{ echo -markup '{Error}Not all buffers were closed' }"
        shift
    done
  }
}

alias global qa kill
alias global qa! kill!
alias global c delete-buffer
alias global c! delete-buffer!
alias global ca delete-all-buffers
alias global ca! delete-all-buffers-force

# Test facespecs
declare-option range-specs face_test_ranges
define-command -params 1 test-face %{
    add-highlighter -override window/face-test-ranges ranges face_test_ranges
    update-option window face_test_ranges
    set-face window test_face %arg{1}
    set-option window face_test_ranges %val{timestamp} "%val{selection_desc}|test_face"
}

define-command -hidden osc-yank \
-docstring "yank selection to terminal clipboard using OSC 52" %{
    nop %sh{
        eval set -- "$kak_quoted_selections"
        copy=$1
        shift
        for sel; do
            copy=$(printf '%s\n%s' "$copy" "$sel")
        done
        encoded=$(printf %s "$copy" | base64 | tr -d '\n')
        printf "\e]52;;%s\e\\" "$encoded" >/dev/tty
    }
}
