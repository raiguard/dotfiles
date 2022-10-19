# Default window settings
hook global WinCreate .* %{
    # Tabs
    expandtab
    set-option window tabstop 4
    set-option window softtabstop 4
    set-option window indentwidth 4

    # Other
    enable-auto-pairs

    try %{
        # Show and automatically update git diff on write
        git show-diff
        hook window BufWritePost .* %{ git update-diff }
        hook window BufReload .* %{ git update-diff }
    }
}

# Remove trailing whitespace on save
hook global BufWritePre .* %{ try %{ execute-keys -draft \%s\h+$<ret>d } }

# Set first client as the jumpclient
hook -once global ClientCreate .* %{
    set global jumpclient "%val{client}"
}

hook global BufOpenFile .* modeline-parse

# Add extra sway commands
hook global ModuleLoaded sway %{
    declare-option str foot_app_id foot
    set-option global termcmd "foot -a %opt{foot_app_id} sh -c"
    hook global WinSetOption foot_app_id=.* %{
        set-option window termcmd "foot -a %opt{foot_app_id} sh -c"
    }
    define-command -params .. terminal-floating %{
        set-option window foot_app_id "foot.floating -w 1528x984"
        terminal %arg{@}
        set-option window foot_app_id foot
    }
}

declare-option bool in_snippet false
hook global WinSetOption snippets_placeholder_groups=.* %{ evaluate-commands %sh{
    eval set -- "$kak_quoted_opt_snippets_placeholder_groups"
    if [ $# = 0 ]; then
        printf %s\\n "
            set-option window in_snippet false
            unmap window insert <tab> '<a-;>: snippets-select-next-placeholders<ret>'
        "
    else
        printf %s\\n "
            set-option window in_snippet true
            map window insert <tab> '<a-;>: snippets-select-next-placeholders<ret>'
        "
    fi
}}
hook global InsertCompletionShow .* %{ evaluate-commands %sh{
    if [ "$kak_opt_in_snippet" = false ]; then
        printf %s\\n "
            map window insert <tab> <c-n>
            map window insert <s-tab> <c-p>
        "
    fi
}}
hook global InsertCompletionHide .* %{
    unmap window insert <tab> <c-n>
    unmap window insert <s-tab> <c-p>
}

# FILETYPES

# Generic
hook global WinSetOption filetype=(css|go|sh) %{
    lsp-init
    rainbow-enable-window
}
hook global WinSetOption filetype=(fish|i3|json|kak|toml) %{
    rainbow-enable-window
}

hook global WinSetOption filetype=(c|cpp) %{
    lsp-init
    rainbow-enable-window

    set-option window tabstop 2
    set-option window softtabstop 2
    set-option window indentwidth 2

    # Highlight operators
    try %{
        remove-highlighter buffer/operators
        add-highlighter    buffer/operators regex (\+|-|\*|&|=|\\|\?|%|\|-|!|\||->|\.|,|<|>|:|\^|/|~|\[|\]) 0:operator
    }
}

hook global BufCreate (.*/|^)changelog\.txt %{
    evaluate-commands %sh{
        # Factorio mods will have an info.json in the same directory
        if [ -f "${kak_hook_param_capture_1}info.json" ]; then
            echo "set-option buffer filetype factorio-changelog"
        fi
    }
}
hook global WinSetOption filetype=factorio-changelog %{
    # Highlighters
    add-highlighter window/changelog_date regex ^(Date):\s(.*?)$ 1:type 2:function
    add-highlighter window/changelog_entry regex ^(\s\s)*(-)\s(.*?)$ 2:value 3:string
    add-highlighter window/changelog_keyword regex ^\s*(Balancing|Bugfixes|Changes|Features|Gui|Info|Optimizations): 1:type
    add-highlighter window/changelog_separator regex ^-+$ 0:keyword
    add-highlighter window/changelog_version regex ^(Version):\s(\d+\.\d+\.\d+)$ 1:type 2:value

    # Two-space indents
    set-option window tabstop 2
    set-option window softtabstop 2
    set-option window indentwidth 2
}

hook global WinSetOption filetype=(git-commit|mail) %{
    set-option window autowrap_column 72
    set-option window autowrap_format_paragraph true
    autowrap-enable
}

hook global WinSetOption filetype=hare %{
    # lsp-init
    rainbow-enable-window

    noexpandtab
    set-option window tabstop 8
    set-option window softtabstop 0
    set-option window indentwidth 0

    add-highlighter window/ruler column 81 ",rgb:%opt{subbg}"
}

hook global WinSetOption filetype=latex %{
    lsp-init
    rainbow-enable-window

    add-highlighter window/ruler column 81 ",black"

    hook window BufWritePre .* lsp-formatting-sync
    define-command latex-automake %{
        hook window BufWritePost .* texlab-build
        evaluate-commands %sh{ echo "pstart 'zathura ${kak_buffile%.tex}.pdf'" }
    }

    define-command create-figure %{
        prompt name: %{
            set-register f %sh{
                inkscape-figures create "$kak_text" "$(dirname $kak_buffile)/figures"
            }
            execute-keys '"fR"zZ'
            execute-keys "sincfig<ret>ll<a-i>B"
            nop %sh{
                ( inkscape "$(dirname $kak_buffile)/figures/$kak_selection.svg" 2>&1 & ) > /dev/null 2>&1 < /dev/null
            }
            execute-keys '"zz'
        }
    }

    define-command edit-figures %{ nop %sh{
        ( inkscape-figures edit "$(dirname $kak_buffile)/figures" 2>&1 & ) > /dev/null 2>&1 < /dev/null
    }}

    declare-user-mode figures
    map global user f ": enter-user-mode figures<ret>" -docstring "figures..."
    map global figures c ": create-figure<ret>" -docstring "create"
    map global figures e ": edit-figures<ret>" -docstring "edit"

    set-option -add global snippets \
    Sum \bsum\b %{snippets-insert "\sum_{$1}^{$2} ($3) $4"} \
    "Block math" bmath %{snippets-insert "$$$$ $1 $$$$"} \
    Fraction // %{snippets-insert "\frac{$1}{$2} $3"} \
    Limit \blim\b %{snippets-insert "\lim_{${1:n} \to ${2:\infty}} $3"} \
    Leq \s<=\s  %{snippets-insert " \leq "}
}

hook global WinSetOption filetype=lua %{
    lsp-init
    rainbow-enable-window

    set-option window tabstop 2
    set-option window softtabstop 2
    set-option window indentwidth 2

    set-option window formatcmd "stylua -"
}

hook global WinSetOption filetype=python %{
    lsp-init
    rainbow-enable-window

    set-option window formatcmd "autopep8 -"
    hook window BufWritePre .* format
}

hook global WinSetOption filetype=rainmeter %{
    rainbow-enable-window

    # Swap variable and operator colors
    face buffer variable "rgb:%opt{lightred}"
    face buffer operator default
}
hook global BufSetOption filetype=rainmeter %{
    set-option buffer comment_line ';'
}

hook global WinSetOption filetype=rust %{
    lsp-init
    rainbow-enable-window
    lsp-inlay-hints-enable window

    # Format on save
    hook window BufWritePre .* lsp-formatting-sync
}

# TODO: Create a kak plugin for this filetype
hook global BufCreate .+\.scd %{
    set-option buffer filetype scdoc
}
hook global WinSetOption filetype=scdoc %{
    noexpandtab
    autowrap-enable
    set-option window autowrap_format_paragraph true
}

hook global WinSetOption filetype=typescript %{
    lsp-init
    rainbow-enable-window

    # Format on save
    hook window BufWritePre .* lsp-formatting-sync
}

hook global WinSetOption filetype=yaml %{
    rainbow-enable-window

    set-option window tabstop 2
    set-option window softtabstop 2
    set-option window indentwidth 2
}
