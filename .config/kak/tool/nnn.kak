define-command nnn -docstring "Open NNN" %{
    kitty-overlay sh -c %{ nnn -H "$1" } -- %val{buffile}
}
map global view f "<esc>: nnn<ret>" -docstring "files"

define-command nnn-pick -file-completion -docstring "Pick file with NNN" %{
    kitty-overlay sh -c %{
        kak_buffile=$1 kak_session=$2 kak_client=$3
        filename=$(nnn -H -p - "$kak_buffile")
        if [ -n "$filename" ]; then
            kak_cmd="evaluate-commands -client $kak_client edit $filename"
            echo $kak_cmd | kak -p $kak_session
        fi
    } -- %val{buffile} %val{session} %val{client}
}
map global normal "<minus>" ": nnn-pick<ret>"
