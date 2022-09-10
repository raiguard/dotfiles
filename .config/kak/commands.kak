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

# Auto complete with tab
define-command map-tab-completion %{
    hook -group tab-completion window InsertCompletionShow .* %{
        map window insert <tab> <c-n>
        map window insert <s-tab> <c-p>
    }
    hook -group tab-completion window InsertCompletionHide .* %{
        unmap window insert <tab> <c-n>
        unmap window insert <s-tab> <c-p>
    }
}
define-command unmap-tab-completion %{
    remove-hooks window tab-completion
    unmap window insert <tab> <c-n>
    unmap window insert <s-tab> <c-p>
}

declare-option range-specs face_test_ranges
define-command -params 1 test-face %{
    add-highlighter -override window/face-test-ranges ranges face_test_ranges
    update-option window face_test_ranges
    set-face window test_face %arg{1}
    set-option window face_test_ranges %val{timestamp} "%val{selection_desc}|test_face"
}
