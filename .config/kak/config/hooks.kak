# Default window settings
hook global WinCreate .* %{
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

    # status-bar-update
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

hook global WinDisplay .* %{
    echo -debug "SET FOR %val{client}"
    # Set status bar format depending on client name
    evaluate-commands %sh{
        if [[ $kak_client == "tools" || $kak_client == "docs" ]]; then
            echo "set window modelinefmt \"{{mode_info}} {keyword}%%val{client}{StatusLineValue} {enum}%%val{session}{StatusLine}\""
        else
            echo "set window modelinefmt \"{string}%%opt{modeline_git_branch} {StatusLineValue}%%val{bufname}{StatusLineValue}:%%val{cursor_line}:%%val{cursor_char_column}{StatusLine} %%sh{expr $kak_cursor_line \* 100 / $kak_buf_line_count}%%%%{{context_info}} {{mode_info}} {keyword}%%val{client}{StatusLineValue} {enum}%%val{session}{StatusLine}\""
        fi
    }
}
