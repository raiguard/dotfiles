# --------------------------------------------------
# PROMPT

# Options

define-command -hidden update-prompt %{
    set-option window promptfmt %sh{
        markup=""
        space=" "
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
            space=""
        else
            markup="{value}"
        fi
        mode=$(echo "$kak_mode" | tr a-z A-Z)
        echo "{comment}[$markup$mode{comment}]$space"
    }
}

# Hooks

hook global WinCreate .* %{
    hook window ModeChange .* update-prompt
    hook -once window WinDisplay .* update-prompt
}

# --------------------------------------------------
# MODELINE

# Options

declare-option -hidden str modeline_lsp_progress_section
define-command -hidden modeline-update-lsp-progress %{
    set-option global modeline_lsp_progress_section %sh{
        if [ -n "$kak_opt_lsp_modeline_progress" ]; then
            echo "{comment}[{default}$kak_opt_lsp_modeline_progress{comment}]"
        fi
    }
}

declare-option -hidden str modeline_lsp_section
define-command -hidden modeline-update-lsp %{
    set-option window modeline_lsp_section %sh{[ "$kak_opt_lsp_enabled" = true ] && echo "{comment}[{InlayDiagnosticError}${kak_opt_lsp_diagnostic_line_error_sign}${kak_opt_lsp_diagnostic_error_count} {InlayDiagnosticWarning}${kak_opt_lsp_diagnostic_line_warning_sign}${kak_opt_lsp_diagnostic_warning_count}{comment}]"}
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
        if [ "$filetype" = "" -a "$kak_buftype" != "file" ]; then
            filetype=$kak_buftype
        fi
        if [ -n "$filetype" ]; then
            echo "{comment}[{type}$filetype{comment}]"
        fi
    }
}

declare-option -hidden str modeline_bufstatus
define-command -hidden modeline-update-bufstatus %{
    set-option window modeline_bufstatus %sh{
        if [ "$kak_opt_readonly" = true ]; then
            echo "{InlayDiagnosticError} "
        elif [ "$kak_modified" = true ]; then
            echo "{InlayDiagnosticWarning}留"
        else
            echo "{string} "
        fi
    }
}

set-option global modelinefmt '%opt{modeline_lsp_progress_section}%opt{modeline_misc_section}%opt{modeline_lsp_section}%opt{modeline_git_branch}{comment}[{function}麗%val{selection_count} %sh{echo $(($kak_selection_index + 1))}{comment}]%opt{modeline_filetype}[%opt{modeline_bufstatus}{StatusLineValue}%val{bufname}{comment}][{enum}%val{cursor_line}:%val{cursor_char_column}{comment}]'

# Hooks

hook global WinSetOption (lsp_diagnostic_error_count|lsp_diagnostic_warning_count|lsp_enabled)=.* modeline-update-lsp
hook global GlobalSetOption lsp_modeline_progress=.* modeline-update-lsp-progress
hook global WinSetOption filetype=.* modeline-update-filetype
hook global WinSetOption modeline_git_branch=.* modeline-update-git-branch

hook -always global NormalIdle .* modeline-update-misc

declare-option -hidden int prev_timestamp
# Custom BufChanged hook
hook global NormalIdle .* %{
    evaluate-commands %sh{
        if [ "$kak_timestamp" -gt "$kak_opt_prev_timestamp" ]; then
            printf 'set-option buffer prev_timestamp %s\n'  "$kak_timestamp"
            printf 'trigger-user-hook BufChanged'
        fi
    }
}
hook global BufWritePost .* modeline-update-bufstatus
hook global User BufChanged modeline-update-bufstatus

hook global WinCreate .* %{
    hook -once window WinDisplay .* %{
        modeline-update-lsp
        modeline-update-misc
        modeline-update-filetype
        modeline-update-git-branch
        modeline-update-bufstatus
    }
    hook window FocusIn .* modeline-update-git-branch
    hook window BufWritePost .* modeline-update-bufstatus
}
