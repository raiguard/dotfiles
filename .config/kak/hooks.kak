# Default window settings
hook global WinCreate .* %{
    # Tabs
    expandtab
    set-option window tabstop 4
    set-option window softtabstop 4
    set-option window indentwidth 4

    # Hide and show cursors when focusing in and out
    hook window FocusOut .* %{
        set-face window PrimaryCursor ""
        set-face window PrimaryCursorEol ""
        set-face window PrimarySelection ""
        set-face window SecondaryCursor ""
        set-face window SecondaryCursorEol ""
        set-face window SecondarySelection ""
    }
    hook window FocusIn .* %{
        try %{
            unset-face window PrimaryCursor
            unset-face window PrimaryCursorEol
            unset-face window PrimarySelection
            unset-face window SecondaryCursor
            unset-face window SecondaryCursorEol
            unset-face window SecondarySelection
        }
    }

    # Other
    map-tab-completion
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

# # Snippet completion
# hook global WinSetOption snippets_placeholder_groups=(.*) %{
#     unmap-tab-completion
#     map window insert <tab> '<a-;>:snippets-select-next-placeholders<ret>'
# }
# hook global WinSetOption snippets_placeholder_groups= %{
#     unmap window insert <tab> '<a-;>:snippets-select-next-placeholders<ret>'
#     map-tab-completion
# }

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
    rainbow-enable-window

    noexpandtab
    set-option window tabstop 8
    set-option window softtabstop 8
    set-option window indentwidth 8

    set-face window meta keyword
}
# Custom hare highlighting
hook global ModuleLoaded hare %{
    add-highlighter shared/hare/code/operator regex "(=|\+|-|\*|/|<|>|;|:|!|\?|,|&|\.\.\.)" 0:operator
    add-highlighter shared/hare/code/function regex "\b(\w*)\(" 1:function
    add-highlighter shared/hare/code/moduleuse regex "\b(\w*)::" 1:module
    add-highlighter shared/hare/code/attribute regex "^(@\w*)" 1:meta
}

hook global WinSetOption filetype=latex %{
    lsp-init
    rainbow-enable-window

    set-option window autowrap_format_paragraph true
    autowrap-enable

    hook window BufWritePre .* lsp-formatting-sync
    define-command latex-automake %{
        hook window BufWritePost .* texlab-build
        evaluate-commands %sh{ echo "pstart 'zathura ${kak_buffile%.tex}.pdf'" }
    }

        set-option -add global snippets \
        Sum \bsum\b %{ snippets-insert "\sum_{$1}^{$2} ($3) $4" } \
        "Block math" bmath %{ snippets-insert "$$$$ $1 $$$$" } \
        Fraction // %{ snippets-insert "\frac{$1}{$2} $3" } \
        Limit \blim\b %{ snippets-insert "\lim_{${1:n} \to ${2:\infty}} $3" }
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
