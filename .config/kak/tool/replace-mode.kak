define-command enter-replace-mode -docstring "Enter replace mode" %{
    hook -group replace-mode window InsertChar "[^\n]" %{ execute-keys "<del>" }
    hook -group replace-mode window InsertDelete "[^\n]" %{ execute-keys "<space><a-;>H" }
    hook -once window ModeChange "pop:insert:.*" %{ remove-hooks window replace-mode }
    execute-keys -with-hooks i
}
map global normal "<a-r>" ": enter-replace-mode<ret>"
