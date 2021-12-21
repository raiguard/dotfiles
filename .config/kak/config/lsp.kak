map global user "l" ": enter-user-mode lsp<ret>" -docstring "lsp..."
map global normal "ⓗ" ": lsp-hover<ret>"
map global normal "<c-a-h>" ": lsp-hover-buffer<ret>"
map global normal "<c-a>" ": lsp-code-actions<ret>"
map global normal "<c-r>" ": lsp-rename-prompt<ret>"
map global normal "<c-e>" ": lsp-diagnostics<ret>"

set global lsp_diagnostic_line_error_sign '×'

set global lsp_hover_anchor true

lsp-auto-hover-insert-mode-enable

def lsp-restart -docstring 'restart lsp server' %{ lsp-stop; lsp-start }

def -hidden lsp-init -docstring "enable lsp and set up generic hooks" %{
    echo -debug "Enabling LSP for filetype %opt{filetype}"
    lsp-enable-window

    set window lsp_auto_highlight_references true

    # Function signature help in status bar
    lsp-auto-signature-help-enable

    # Semantic tokens
    hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
    hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
    hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
    hook -once -always window WinSetOption filetype=.* %{
        rmhooks window semantic-tokens
    }

    # Enable inlay diagnostics
    inlay-diagnostics-enable
}

# Auto-hide inlay diagnostics in insert mode, if they're enabled at all
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

hook global KakEnd .* lsp-exit

declare-option -hidden str lsp_modeline_progress ""
define-command -hidden -params 6 -override lsp-handle-progress %{
    set-option global lsp_modeline_progress %sh{
        if ! "$6"; then
            echo "$2${5:+" ($5%)"}${4:+": $4"}"
        fi
    }
}
