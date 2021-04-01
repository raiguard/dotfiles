##
## git-branch.kak by lenormf
## Store the current git branch that contains the buffer
##

declare-option -docstring "name of the git branch holding the current buffer" str modeline_git_branch

hook global WinCreate .* %{
    hook window NormalIdle .* %{ evaluate-commands %sh{
        branch=$(cd "$(dirname "${kak_buffile}")" && git rev-parse --abbrev-ref HEAD 2>/dev/null)
        if [ -n "${branch}" ]; then
            printf 'set window modeline_git_branch %%{%s}' "${branch}"
        fi
    } }
}

hook global WinCreate .* %{ evaluate-commands %sh{
    is_work_tree=$(cd "$(dirname "${kak_buffile}")" && git rev-parse --is-inside-work-tree 2>/dev/null)
    if [ "${is_work_tree}" = 'true' ]; then
        printf 'set-option window modelinefmt %%{%s}' " %opt{modeline_git_branch} ${kak_opt_modelinefmt}"
    fi
}}
