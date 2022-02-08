# Default window settings
hook global WinCreate .* %{
    try %{
        expandtab
        set-option window tabstop 4
        set-option window softtabstop 4
        set-option window indentwidth 4

        # Enable plugins
        kakboard-enable

        # Show and automatically update git diff on write
        git show-diff
        hook window BufWritePost .* %{ git update-diff }
        hook window BufReload .* %{ git update-diff }
    }
}

# Remove trailing whitespace on save
hook global BufWritePre .* %{ try %{ execute-keys -draft \%s\h+$<ret>d } }

# Auto complete with tab
hook global InsertCompletionShow .* %{
    map window insert <tab> <c-n>
    map window insert <s-tab> <c-p>
}
hook global InsertCompletionHide .* %{
    map window insert <tab> <tab>
    map window insert <s-tab> <s-tab>
}

hook global FocusIn .* %{
    set-face window LineNumbers "rgb:%opt{comment}"
}

hook global FocusOut .* %{
    set-face window LineNumbers "rgb:%opt{comment}+d"
}
