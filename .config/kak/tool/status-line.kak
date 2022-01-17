# PROMPT

declare-option -hidden str prompt_mode ""

define-command -hidden update-prompt-mode %{
    set-option window prompt_mode %sh{
        markup=""
        if [ $kak_mode = "normal" ]; then
            markup="{string}"
        elif [ $kak_mode = "insert" ]; then
            markup="{type}"
        elif [ $kak_mode = "goto" ]; then
            markup="{keyword}"
        elif [ $kak_mode = "view" ]; then
            markup="{keyword}"
        elif [ $kak_mode = "prompt" ]; then
            markup="{function}"
        else
            markup="{value}"
        fi
        mode=$(echo "$kak_mode" | tr a-z A-Z)
        echo "$markup$mode"
    }
}

hook global WinCreate .* %{
    hook window ModeChange .* update-prompt-mode
    hook -once window WinDisplay .* update-prompt-mode
}

set-option global promptfmt '{comment}[{value}%opt{prompt_mode}{comment}]'

# MODELINE

declare-option -hidden str modeline_lsp_progress_section
declare-option -hidden str modeline_lsp_section
define-command -hidden modeline-update-lsp %{
    set-option window modeline_lsp_progress_section %sh{[ "$kak_opt_lsp_enabled" = true ] && echo "{StatusLine}%opt{lsp_modeline_progress} "}
    set-option window modeline_lsp_section %sh{[ "$kak_opt_lsp_enabled" = true ] && echo "{comment}[{InlayDiagnosticError}%opt{lsp_diagnostic_line_error_sign}%opt{lsp_diagnostic_error_count} {InlayDiagnosticWarning}%opt{lsp_diagnostic_line_warning_sign}%opt{lsp_diagnostic_warning_count}{comment}]"}
}

declare-option -hidden str modeline_misc_section
define-command -hidden modeline-update-misc %{
    set-option window modeline_misc_section %sh{
        misc_section=$(
            [ -n "$kak_recording_reg" ] && echo "雷$kak_recording_reg"
            [ -n "$kak_current_reg" ] && echo "凌$kak_current_reg"
            [ "$kak_current_count" != "0" ] && echo "𧻓$kak_current_count"
        )
        if [ "$misc_section" != "" ]; then
            echo "{comment}[{value}$misc_section{comment}]"
        fi
    }
}

declare-option -hidden str modeline_git_branch
define-command -hidden modeline-update-git-branch %{
    set-option window modeline_git_branch %sh{
        branch=$(git -C "${kak_buffile%/*}" rev-parse --abbrev-ref HEAD 2>/dev/null)
        if [ -n "$branch" ]; then
            printf "{comment}[{string} $branch{comment}]"
        fi
    }
}

declare-option -hidden str modeline_filetype
define-command -hidden modeline-update-filetype %{
    set-option window modeline_filetype %sh{
        filetype=$kak_opt_filetype
        if [ "$filetype" == "" -a "$kak_buftype" != "file" ]; then
            filetype=$kak_buftype
        fi
        if [ -n "$filetype" ]; then
            echo "{comment}[{type}$filetype{comment}]"
        fi
    }
}

set global modelinefmt '%opt{modeline_lsp_progress_section}%opt{modeline_misc_section}%opt{modeline_lsp_section}%opt{modeline_git_branch}{comment}[{function}麗%val{selection_count} %val{selection_index}{comment}]%opt{modeline_filetype}[{StatusLineValue}%val{bufname}{comment}][{enum}%val{cursor_line}:%val{cursor_char_column}{comment}]'

hook global WinSetOption lsp_enabled=.* modeline-update-lsp
hook global WinSetOption filetype=.* modeline-update-filetype
hook global WinSetOption modeline_git_branch=.* modeline-update-git-branch

hook global ModeChange .* modeline-update-misc
hook global NormalKey Q modeline-update-misc
hook global NormalKey [0-9] %{
    modeline-update-misc
    hook -once window NormalKey [^0-9] %{
        modeline-update-misc
    }
}
hook global NormalKey <esc> modeline-update-misc


hook global WinCreate .* %{
    hook -once window WinDisplay .* %{
        modeline-update-lsp
        modeline-update-misc
        modeline-update-filetype
        modeline-update-git-branch
    }
    hook window FocusIn .* update-git-branch
}
