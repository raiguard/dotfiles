# Originally part of `move-line.kak` by alexherbo2, but the plugin was deleted...

define-command -override -docstring 'move line down' -params 1 move-lines-down %{
    evaluate-commands %sh{
        count=$(($1 > 0 ? $1 : 1))
        for i in `seq 1 $count`
        do
            echo "execute-keys -draft 'x<a-_><a-:>Z;ezjxdzP'"
        done
    }
}

define-command -override -docstring 'move line up' -params 1 move-lines-up %{
    evaluate-commands %sh{
        count=$(($1 > 0 ? $1 : 1))
        for i in `seq 1 $count`
        do
          echo "execute-keys -draft 'x<a-_><a-:><a-;>Z;bzkxdzp'"
        done
    }
}

map global normal <c-s-j> ': move-lines-down %val{count}<ret>'
map global normal <c-s-k> ': move-lines-up %val{count}<ret>'
