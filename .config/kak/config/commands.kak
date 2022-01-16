define-command edit-kakrc %{ e ~/.config/kak/kakrc }

define-command ide %{
    rename-client main
    set-option global jumpclient main

    new-horizontal-split eval %{ rename-client tools; edit -scratch *tools-scratch*; status-bar-update }
    set-option global toolsclient tools

    focus main
}

alias global qa kill
alias global qa! kill!
alias global c delete-buffer
alias global c! delete-buffer!
