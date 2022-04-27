# Originally part of `move-line.kak` by alexherbo2, but the plugin was deleted...

define-command -override move-lines-down -docstring 'move line down' %{
  execute-keys -draft 'x<a-_><a-:>Z;ezjxdzP'
}

define-command -override move-lines-up -docstring 'move line up' %{
  execute-keys -draft 'x<a-_><a-:><a-;>Z;bzkxdzp'
}

map global normal "<a-j>" ": move-lines-down<ret>"
map global normal "<a-k>" ": move-lines-up<ret>"
