map global user "l" ": enter-user-mode lsp<ret>" -docstring "lsp..."

set global lsp_diagnostic_line_error_sign '✕'

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

    # Enable inlay diagnostics
    inlay-diagnostics-enable
}

hook global KakEnd .* lsp-exit

declare-option -hidden str modeline_progress ""
define-command -hidden -params 4 -override lsp-handle-progress %{
  set global modeline_progress %sh{
    echo $1${2:+": $2"}${3:+" $3%"}${4:+" ✓"}
  }
}
