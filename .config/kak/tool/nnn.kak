# Pick a file then open it in kak
define-command nnn-current -params 0..1 -file-completion -docstring 'Open file with nnn (volatile)' %{
    kitty-overlay sh -c %{
        kak_buffile=$1 kak_session=$2 kak_client=$3
        shift 3
        filename=$(nnn -H -p - "$kak_buffile")
        if [ -n "$filename" ]; then
            kak_cmd="evaluate-commands -client $kak_client edit $filename"
            echo $kak_cmd | kak -p $kak_session
        fi
    } -- %val{buffile} %val{session} %val{client} %arg{@}
}
map global normal "<minus>" ": nnn-current<ret>"

# Manage files
map global view f "<esc>: nnn<ret>" -docstring "files"

define-command nnn -docstring "Open nnn in the project directory" %{
    kitty-overlay sh -c %{ nnn -H "$1" } -- %val{buffile}
}
