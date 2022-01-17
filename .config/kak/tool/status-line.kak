# PROMPT

declare-option -hidden str prompt_mode ""

define-command -hidden update-prompt-mode %{
    set-option window prompt_mode %sh{
        # if [ $kak_mode = "normal" ]; then
        #     echo "{string}NORMAL"
        # elif [ $kak_mode = "insert" ]; then
        #     echo "{type}INSERT"
        # elif [ $kak_mode = "goto" ]; then
        #     echo "{keyword}GOTO"
        # elif [ $kak_mode = "view" ]; then
        #     echo "{keyword}VIEW"
        # elif [ $kak_mode = "prompt" ]; then
        #     echo "{function}PROMPT"
        # else
        #     echo "{value}$kak_mode"
        # fi

        echo "$kak_mode" | tr a-z A-Z
    }
}

hook global WinCreate .* %{
    hook window ModeChange .* update-prompt-mode
    hook -once window WinDisplay .* update-prompt-mode
}

set-option global promptfmt '{comment}[{value}%opt{prompt_mode}{comment}]'

# MODELINE

define-command modeline-update \
-docstring "Update the modeline contents based on window contents" \
%{
    set-option window modelinefmt %sh{
        lsp_section=$([ "$kak_opt_lsp_enabled" = true ] && echo "{StatusLine}%opt{lsp_modeline_progress} {comment}[{InlayDiagnosticError}%opt{lsp_diagnostic_line_error_sign}%opt{lsp_diagnostic_error_count} {InlayDiagnosticWarning}%opt{lsp_diagnostic_line_warning_sign}%opt{lsp_diagnostic_warning_count}{comment}]")
        filetype_section=$(
            filetype=$kak_opt_filetype
            if [ "$filetype" == "" -a "$kak_buftype" != "file" ]; then
                filetype=$kak_buftype
            fi
            if [ -n "$filetype" ]; then
                echo "{comment}[{type}$filetype{comment}]"
            fi
        )
        git_branch_section=$([ -n "$kak_opt_modeline_git_branch" ] && echo "{comment}[{string}$kak_opt_modeline_git_branch{comment}]")

        echo "$lsp_section$git_branch_section{comment}[{function}麗%val{selection_count} %val{selection_index}{comment}]$filetype_section[{StatusLineValue}%val{bufname}{comment}][{enum}%val{cursor_line}:%val{cursor_char_column}{comment}][{keyword}%val{client}/%val{session}{comment}]"
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

