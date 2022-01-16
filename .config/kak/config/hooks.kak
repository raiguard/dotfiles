# Default window settings
hook global WinCreate .* %{
    try %{
        expandtab
        set window tabstop 4
        set window softtabstop 4
        set window indentwidth 4

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

# Configure status bar when a window is shown
hook global WinDisplay .* %{ status-bar-update }

# Disable escape to end macro
hook global NormalKey Q %{
    map global normal "<esc>" ""
    hook -always -once global NormalKey Q %{ unmap global normal "<esc>" "" }
}

hook global FocusIn .* %{
    set-face window StatusLine "default,rgb:%opt{subbg}"
    set-face window LineNumbers "rgb:%opt{comment}"
}

hook global FocusOut .* %{
    set-face window StatusLine "default,rgb:%opt{bg}"
    set-face window LineNumbers "rgb:%opt{comment}+d"
}
