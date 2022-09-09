# Default window settings
hook global WinCreate .* %{
    try %{
        # Tabs
        expandtab
        set-option window tabstop 4
        set-option window softtabstop 4
        set-option window indentwidth 4

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

# FILETYPES

# All
hook global WinCreate .* %{
    map-tab-completion
}

# Generic
hook global WinSetOption filetype=(css|go) %{
    lsp-init
    rainbow-enable-window
}
hook global WinSetOption filetype=(fish|i3|json|kak|python|sh|toml) %{
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
    set-option global autowrap_column 72
    set-option global autowrap_format_paragraph true
    autowrap-enable
}

hook global WinSetOption filetype=hare %{
    rainbow-enable-window

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
}

hook global WinSetOption filetype=latex %{
    lsp-init
    rainbow-enable-window

    hook window BufWritePre .* lsp-formatting-sync
    define-command latex-automake %{
        hook window BufWritePost .* texlab-build
        evaluate-commands %sh{ echo "pstart 'zathura ${kak_buffile%.tex}.pdf'" }
    }

    hook window WinSetOption snippets_placeholder_groups=(.+) %{
        echo -debug "snippet entered"
        unmap-tab-completion
        map window insert <tab> '<a-;>:snippets-select-next-placeholders<ret>'
    }
    hook window WinSetOption snippets_placeholder_groups= %{
        echo -debug "snippet exited"
        unmap window insert <tab> '<a-;>:snippets-select-next-placeholders<ret>'
        map-tab-completion
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
