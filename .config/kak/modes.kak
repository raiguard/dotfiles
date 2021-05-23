declare-user-mode sort
map global user "s" ": enter-user-mode sort<ret>" -docstring "sort..."
map global sort "e" "<esc>|sort<ret>" -docstring "external"
map global sort "s" "<esc>: sort-selections<ret>" -docstring "selections"
