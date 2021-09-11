define-command enter-replace-mode -docstring 'Enter replace mode' %{
    hook -group replace-mode window InsertChar '[^\n]' replace-mode-character-inserted
    hook -group replace-mode window InsertDelete '[^\n]' replace-mode-character-deleted
    hook -once window ModeChange 'pop:insert:.*' %{
      remove-hooks window replace-mode
    }
    execute-keys -with-hooks i
}

define-command -hidden replace-mode-character-inserted %{
    execute-keys '<del>'
}

define-command -hidden replace-mode-character-deleted %{
    execute-keys '<space><a-;>H'
}

map global normal <a-r> ": enter-replace-mode<ret>"
