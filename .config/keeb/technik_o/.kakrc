# Automatically align the keymap on every save
define-command align-keymap %{
    execute-keys '"zZ<percent>sLAYOUT_ortho_4x12<ret>j'
    execute-keys -itersel '<a-i>is,\s<plus><ret><a-K>\n<ret>c,<space><esc><space><semicolon><a-i>is[^\s]*(,|\n)<ret><a-semicolon>&<space><semicolon>'
    execute-keys '"zz'
    echo 'Keymap aligned'
}
hook global BufWritePre .*keymap\.c align-keymap
hook global BufCreate .*keymap\.c %{
    add-highlighter buffer/ regex "_______" 0:comment
}
