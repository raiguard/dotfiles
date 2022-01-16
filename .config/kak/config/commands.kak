def edit-kakrc %{ e ~/.config/kak/kakrc }

def ide %{
    rename-client main
    set global jumpclient main

    new-horizontal-split eval %{ rename-client tools; edit -scratch *tools-scratch*; status-bar-update }
    set global toolsclient tools

    focus main
}

alias global qa kill
alias global qa! kill!
alias global c delete-buffer
alias global c! delete-buffer!
