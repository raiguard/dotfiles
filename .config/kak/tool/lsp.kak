map global user l ": enter-user-mode lsp<ret>" -docstring "lsp..."
map global normal "ⓗ" ": lsp-hover<ret>"
map global normal <c-a-h> ": lsp-hover-buffer<ret>"
map global normal <c-a> ": lsp-code-actions<ret>"
map global normal <c-r> ": lsp-rename-prompt<ret>"
map global normal <c-e> ": lsp-diagnostics<ret>"

set-option global lsp_diagnostic_line_error_sign "×"
set-option global lsp_hover_anchor true
set-option global lsp_auto_highlight_references true
set-option global lsp_hover_max_lines 50

lsp-inlay-diagnostics-enable global
lsp-inlay-hints-enable global
lsp-auto-signature-help-enable


define-command lsp-restart -docstring "Restart kak-lsp session" %{ lsp-stop; lsp-start }

define-command lsp-init -docstring "Enable LSP with default setting" %{
    echo -debug "Enabling LSP for filetype %opt{filetype}"
    lsp-enable-window
    set-option window lsp_enabled true

    # Semantic tokens
    # TODO: These hooks should be in kak-lsp
    hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
    hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
    hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
    hook -once -always window WinSetOption filetype=.* %{
        rmhooks window semantic-tokens
    }
}

hook global KakEnd .* lsp-exit

# Custom status line

declare-option bool lsp_enabled false
declare-option -hidden str lsp_modeline_progress ""
define-command -hidden -params 6 -override lsp-handle-progress %{
    set-option global lsp_modeline_progress %sh{
        if ! "$6"; then
            echo "$2${5:+" ($5%)"}${4:+": $4"}"
        fi
    }
}
