def edit-kakrc %{ e ~/.config/kak/kakrc }

def ide %{
    rename-client main
    set global jumpclient main

    new eval %{ rename-client tools; edit -scratch *tools-scratch*; status-bar-update }
    set global toolsclient tools

    focus main
}

def status-bar-update %{
    # Set status bar format depending on client name
    evaluate-commands %sh{
        if [[ $kak_client == "tools" || $kak_client == "docs" ]]; then
            echo "set window modelinefmt \"%%val{bufname} {{mode_info}} {keyword}%%val{client}{StatusLineValue} {enum}%%val{session}{StatusLine}\""
        else
            echo "set window modelinefmt \"{red}%%opt{lsp_diagnostic_line_error_sign}%%opt{lsp_diagnostic_error_count} {yellow}%%opt{lsp_diagnostic_line_warning_sign}%%opt{lsp_diagnostic_warning_count} {string}%%opt{modeline_git_branch} {StatusLineValue}%%val{bufname}{StatusLineValue}:%%val{cursor_line}:%%val{cursor_char_column}{StatusLine}{{context_info}} {yellow}%%opt{filetype} {{mode_info}} {keyword}%%val{client}{StatusLineValue} {enum}%%val{session}{StatusLine}\""
        fi
    }
}

alias global qa kill
alias global qa! kill!
