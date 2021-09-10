# Originally part of `move-line.kak` by alexherbo2, but the plugin was deleted...

define-command -override move-lines-down -docstring 'move line down' %{
  execute-keys -draft '<a-x><a-_><a-:>Z;ezj<a-x>dzP'
}

define-command -override move-lines-up -docstring 'move line up' %{
  execute-keys -draft '<a-x><a-_><a-:><a-;>Z;bzk<a-x>dzp'
}
