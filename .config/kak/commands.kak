def edit-kakrc %{ e ~/.config/kak/kakrc }

def ide -params 0..1 %{
    try %{ rename-session %arg{1} }

    rename-client main
    set global jumpclient main

    new rename-client tools
    set global toolsclient tools

    new rename-client docs
    set global docsclient docs
}

alias global qa quit
alias global qa! quit!
alias global q delete-buffer
alias global q! delete-buffer!

def -hidden rust-analyzer-inlay-hints-toggle %{
    try %{
        addhl window/rust_analyzer_inlay_hints replace-ranges rust_analyzer_inlay_hints
    } catch %{
        rmhl window/rust_analyzer_inlay_hints
    }
}

def inlay-diagnostics-enable %{
    lsp-inlay-diagnostics-enable window
    hook window -group inlay-diagnostics ModeChange (push|pop):.*:insert %{
        lsp-inlay-diagnostics-disable window
    }
    hook window -group inlay-diagnostics ModeChange (push|pop):insert:.* %{
        lsp-inlay-diagnostics-enable window
    }
}

def inlay-diagnostics-disable %{
    lsp-inlay-diagnostics-disable window
    remove-hooks window inlay-diagnostics
}
