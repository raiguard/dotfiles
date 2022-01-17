define-command modeline-update \
-docstring "Update the modeline contents based on window contents" \
%{
    evaluate-commands %sh{
        lsp_section=$([ "$kak_opt_lsp_enabled" = true ] && echo "{StatusLine}%opt{lsp_modeline_progress} {comment}[{InlayDiagnosticError}%opt{lsp_diagnostic_line_error_sign}%opt{lsp_diagnostic_error_count} {InlayDiagnosticWarning}%opt{lsp_diagnostic_line_warning_sign}%opt{lsp_diagnostic_warning_count}{comment}]")
        filetype_section=$([ -n "$kak_opt_filetype" ] && echo "{comment}[{InlayDiagnosticWarning}$kak_opt_filetype{comment}]")
        git_branch_section=$([ -n "$kak_opt_modeline_git_branch" ] && echo "{comment}[{string}$kak_opt_modeline_git_branch{comment}]")

        echo "set-option window modelinefmt '$lsp_section$git_branch_section$filetype_section{comment}[{StatusLineValue}%val{bufname}{{context_info}}{comment}][{function}%val{cursor_line}:%val{cursor_char_column}{comment}][{keyword}%val{client}/%val{session}{comment}]'"
    }
}

hook global WinSetOption lsp_enabled=.* modeline-update
hook global WinSetOption filetype=.* modeline-update
hook global WinSetOption modeline_git_branch=.* modeline-update

# Writes the active git branch to an option, for display in the modeline

declare-option -hidden str modeline_git_branch

define-command -hidden update-git-branch %{
    set-option window modeline_git_branch %sh{
        branch=$(git -C "${kak_buffile%/*}" rev-parse --abbrev-ref HEAD 2>/dev/null)
        if [ -n "$branch" ]; then
            printf " $branch"
        fi
    }
}

hook global WinCreate .* %{
    hook -once window WinDisplay .* update-git-branch
    hook window FocusIn .* update-git-branch
}

# Poor man's promptfmt

hook global NormalIdle .* %{
    echo -markup "{comment}[{string}NORMAL{comment}]"
}

hook global InsertIdle .* %{
    echo -markup "{comment}[{type}INSERT{comment}]"
}
