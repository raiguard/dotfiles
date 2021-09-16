# Pick a file then open it in kak
# Depends on raiguard/kitty.kak for the overlay window
define-command nnn-current -params 0..1 -file-completion -docstring 'Open file with nnn (volatile)' %{
    kitty-overlay sh -c %{
        kak_buffile=$1 kak_session=$2 kak_client=$3
        shift 3
        kak_pwd="${@:-$(dirname "${kak_buffile}")}"
        filename=$(
            # Set colors
            BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
            export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
            # Launch NNN
            nnn -H -p - "${kak_pwd}"
        )
        kak_cmd="evaluate-commands -client $kak_client edit $filename"
        echo $kak_cmd | kak -p $kak_session
    } -- %val{buffile} %val{session} %val{client} %arg{@}
}
map global normal "<minus>" ": nnn-current<ret>"

# Manage files
map global view f "<esc>: connect kitty-terminal-overlay nnn<ret>" -docstring "files"
