# Prompt
set-face global StatusLineModeNormal "rgb:%opt{green}"
set-face global StatusLineModeInsert "rgb:%opt{lightorange}"
set-face global StatusLineModeGotoView "rgb:%opt{magenta}"
set-face global StatusLineModeOther "rgb:%opt{darkorange}"
set-option global promptfmt '{comment}[{StatusLineModeNormal}%sh{[ $kak_mode = "normal" ] && echo "$kak_mode" | tr a-z A-Z}{StatusLineModeInsert}%sh{[ $kak_mode = "insert" ] && echo "$kak_mode" | tr a-z A-Z}{StatusLineModeGotoView}%sh{[ $kak_mode = "goto" -o $kak_mode = "view" ] && echo "$kak_mode" | tr a-z A-Z}{StatusLineModeOther}%sh{[ $kak_mode != "normal" -a $kak_mode != "insert" -a $kak_mode != "goto" -a $kak_mode != "view" ] && echo "$kak_mode" | tr a-z A-Z}{comment}]'

# MODELINE

set-option global modelinefmt '{comment}'

# [recording_reg current_reg current_count]
set-option -add global modelinefmt  '%sh{[ "${kak_recording_reg}${kak_current_reg}${kak_current_count}" != "0" ] && echo [}{StatusLineMode}'
set-option -add global modelinefmt  '%sh{
    [ -n "${kak_recording_reg}" ] && echo "雷${kak_recording_reg}"
    [ -n "${kak_current_reg}" ] && echo "凌${kak_current_reg}"
    [ "${kak_current_count}" != "0" ] && echo "𧻓${kak_current_count}"
}'
set-option -add global modelinefmt  '{comment}%sh{[ "${kak_recording_reg}${kak_current_reg}${kak_current_count}" != "0" ] && echo ]}'

# [lsp_progress lsp_errors lsp_warnings]
set-option -add global modelinefmt '%sh{[ $kak_opt_lsp_enabled = true ] && echo [}'
set-option -add global modelinefmt '%sh{[ -n "$kak_opt_lsp_modeline_progress" ] && echo "{StatusLine}$kak_opt_lsp_modeline_progress "}'
set-option -add global modelinefmt '{InlayDiagnosticError}%sh{[ $kak_opt_lsp_enabled = true ] && echo "${kak_opt_lsp_diagnostic_line_error_sign}${kak_opt_lsp_diagnostic_error_count}"} {InlayDiagnosticWarning}%sh{[ $kak_opt_lsp_enabled = true ] && echo "${kak_opt_lsp_diagnostic_line_warning_sign}${kak_opt_lsp_diagnostic_warning_count}"}{comment}%sh{[ $kak_opt_lsp_enabled = true ] && echo ]}'

# [git branch]
set-option -add global modelinefmt '%sh{[ -n "$kak_opt_modeline_git_branch" ] && echo [}{string}%sh{[ -n "$kak_opt_modeline_git_branch" ] && echo "$kak_opt_modeline_git_branch"}{comment}%sh{[ -n "$kak_opt_modeline_git_branch" ] && echo ]}'

# [selection info]
set-option -add global modelinefmt  '[{function}麗%val{selection_count} %sh{ echo $((${kak_selection_index} + 1))}{comment}]'

# [filetype or buftype]
set-option -add global modelinefmt  '[{type}%sh{[ "${kak_opt_filetype}" = "" ] && echo ${kak_buftype} || echo ${kak_opt_filetype}}{comment}]'

# [status filename]
set-option -add global modelinefmt  '[{InlayDiagnosticError}%sh{[ ${kak_read_only} = "true" ] && echo " "}{InlayDiagnosticWarning}%sh{[ ${kak_modified} = "true" -o ${kak_new} = "true" ] && echo "留"}{string}%sh{[ $kak_read_only = false -a $kak_modified = false -a $kak_new = false ] && echo " "}'
set-option -add global modelinefmt  '{StatusLineValue}%val{bufname}{comment}]'

# [cursor_line:cursor_column]
set-option -add global modelinefmt  '[{enum}%sh{printf "%04d" ${kak_cursor_line}}:%sh{printf "%03d" ${kak_cursor_char_column}}{comment}]'

# [client/session]
set-option -add global modelinefmt '[{keyword}%val{client}/%val{session}{comment}]'

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
