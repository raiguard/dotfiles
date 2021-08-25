##
## git-branch.kak by lenormf
## Store the current git branch that contains the buffer
##

provide-module git-branch %{
    declare-option -docstring "name of the git branch holding the current buffer" str modeline_git_branch

    hook global WinCreate .* %{
        hook window NormalIdle .* %{ evaluate-commands %sh{
            branch=$(cd "$(dirname "${kak_buffile}")" && git rev-parse --abbrev-ref HEAD 2>/dev/null)
            if [ -n "${branch}" ]; then
                printf 'set window modeline_git_branch %%{%s}' " ${branch}"
            fi
        } }
    }
}

