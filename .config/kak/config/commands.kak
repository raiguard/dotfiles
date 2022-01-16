define-command edit-kakrc %{ e ~/.config/kak/kakrc }

define-command ide %{
    rename-client main
    set-option global jumpclient main

    new-horizontal-split eval %{ rename-client tools; edit -scratch *tools-scratch*; status-bar-update }
    set-option global toolsclient tools

    focus main
}

define-command buffer-only -docstring 'delete all saved buffers except current one' %{
  evaluate-commands %sh{
    deleted=0
    eval "set-option -- $kak_quoted_buflist"
    while [ "$1" ]; do
      if [ "$1" != "$kak_bufname" ]; then
        echo "try %{delete-buffer '$1'}"
        echo "echo -markup '{Information}$deleted buffers deleted'"
        deleted=$((deleted+1))
      fi
      shift
    done
  }
}

define-command buffer-only-force -docstring 'delete all buffers except current one' %{
  evaluate-commands %sh{
    deleted=0
    eval "set-option -- $kak_quoted_buflist"
    while [ "$1" ]; do
      if [ "$1" != "$kak_bufname" ]; then
        echo "delete-buffer! '$1'"
        echo "echo -markup '{Information}$deleted buffers deleted'"
        deleted=$((deleted+1))
      fi
      shift
    done
  }
}

alias global qa kill
alias global qa! kill!
alias global c delete-buffer
alias global c! delete-buffer!
alias global ca buffer-only
alias global ca! buffer-only-force
