# def edit-kakrc %{ e ~/.config/kak/kakrc }

def ide %{
    rename-client main
    set global jumpclient main

    new eval %{ rename-client tools; edit -scratch *tools-scratch* }
    set global toolsclient tools

    new eval %{ rename-client docs; edit -scratch *docs-scratch* }
    set global docsclient docs

    focus main
}

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
