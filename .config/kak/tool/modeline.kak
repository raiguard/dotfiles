define-command modeline-update \
-docstring "Update the modeline contents based on window contents" \
%{
    evaluate-commands %sh{
        # Show a reduced modeline in utility clients
        if [[ $kak_client == "tools" || $kak_client == "docs" ]]; then
            echo "set-option window modelinefmt \"%%val{bufname} {{mode_info}} {keyword}%%val{client}{StatusLineValue} {enum}%%val{session}{StatusLine}\""
        else
            lsp_section=$( [ "$kak_opt_lsp_enabled" = true ] && echo "{comment}%%opt{lsp_modeline_progress}  {InlayDiagnosticError}%%opt{lsp_diagnostic_line_error_sign}%%opt{lsp_diagnostic_error_count} {InlayDiagnosticWarning}%%opt{lsp_diagnostic_line_warning_sign}%%opt{lsp_diagnostic_warning_count}  " )
            filetype_section=$( [ -n "$kak_opt_filetype" ] && echo "{InlayDiagnosticWarning}%%opt{filetype} " )

            echo "set-option window modelinefmt \"$lsp_section{string}%%opt{modeline_git_branch}{StatusLineValue}%%val{bufname}{StatusLineValue}:%%val{cursor_line}:%%val{cursor_char_column}{StatusLine}{{context_info}} $filetype_section{{mode_info}} {keyword}%%val{client}{StatusLineValue} {enum}%%val{session}{StatusLine}\""
        fi
    }
}

hook global WinSetOption lsp_enabled=.* modeline-update
hook global WinSetOption filetype=.* modeline-update

hook global WinDisplay .* modeline-update

# Writes the active git branch to an option, for display in the modeline

declare-option -hidden str modeline_git_branch

define-command -hidden update-git-branch %{
    set-option window modeline_git_branch %sh{
        branch=$(cd "${kak_buffile%/*}" 2>/dev/null && git rev-parse --abbrev-ref HEAD 2>/dev/null)
        if [ -n "$branch" ]; then
            printf " $branch "
        fi
    }
}

hook global WinCreate .* %{
    hook -once window WinDisplay .* update-git-branch
    hook window FocusIn .* update-git-branch
}
