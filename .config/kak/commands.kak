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
