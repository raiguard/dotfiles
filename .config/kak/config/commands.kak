# def edit-kakrc %{ e ~/.config/kak/kakrc }

def ide %{
    rename-client main
    set global jumpclient main

    new eval %{ rename-client tools; edit -scratch *tools-scratch*; status-bar-update }
    set global toolsclient tools

    new eval %{ rename-client docs; edit -scratch *docs-scratch*; status-bar-update; }
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

def status-bar-update %{
    # Set status bar format depending on client name
    evaluate-commands %sh{
        if [[ $kak_client == "tools" || $kak_client == "docs" ]]; then
            echo "set window modelinefmt \"{{mode_info}} {keyword}%%val{client}{StatusLineValue} {enum}%%val{session}{StatusLine}\""
        else
            echo "set window modelinefmt \"%%opt{modeline_progress} {string}%%opt{modeline_git_branch} {StatusLineValue}%%val{bufname}{StatusLineValue}:%%val{cursor_line}:%%val{cursor_char_column}{StatusLine} %%sh{expr $kak_cursor_line \* 100 / $kak_buf_line_count}%%%%{{context_info}} {{mode_info}} {keyword}%%val{client}{StatusLineValue} {enum}%%val{session}{StatusLine}\""
        fi
    }
}
