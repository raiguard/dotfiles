# Comment
map global normal "#" ": comment-line<ret>"
map global normal "<a-#>" ": comment-block<ret>"

# Go to file (basic fuzzy finder)
map global goto "f" '<esc>: prompt -shell-script-candidates %{ rg --files } file: %{ edit %val{text} }<ret>' -docstring "file"

# Go to buffer
map global goto "b" '<esc>: prompt -buffer-completion buffer: %{ buffer %val{text} }<ret>' -docstring "buffer"

# View files
map global normal "<minus>" "<esc>: connect kitty-terminal-overlay nnn<ret>" -docstring "files..."
decl pick-nnn %{
    edit %sh{
        echo "echo -debug foo"
        BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
        export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
        nnn -p -
    }
}

# View lazygit
map global view "g" "<esc>: kitty-terminal-overlay lazygit<ret>" -docstring "lazygit..."

# Grep for current selection
map global user "/" ': grep %reg{dot}<ret>' -docstring "grep for selection"

# Jumps centered please
map global normal "<c-i>" "<c-i>vv"
map global normal "<c-o>" "<c-o>vv"

# Search results centered please
map global normal "n" "nvv"
map global normal "N" "Nvv"
map global normal "<a-n>" "<a-n>vv"
map global normal "<a-N>" "<a-N>vv"

# Swap user mode and clear selection keys
map global normal "<space>" ","
map global normal "," "<space>"
map global normal "<a-,>" "<a-space>"

# Less awkward keybind for outer object
map global normal "<a-o>" "<a-a>"

# Search case-insensitive by default
map global normal "/" "/(?i)"
map global normal "?" "?(?i)"
map global normal "<a-/>" "<a-/>(?i)"
map global normal "<a-?>" "<a-?>(?i)"

# Free alt-movement keys
map global normal "<a-a>" "<a-j>"
map global normal "<a-A>" "<a-J>"
map global normal "<a-m>" "<a-k>"
map global normal "<a-M>" "<a-K>"

# Always select entire lines
map global normal "J" "J<a-x>"
map global normal "K" "K<a-x>"

# Except when I don't want to
map global normal "<c-a-j>" "J"
map global normal "<c-a-k>" "K"

# Remap extend-line to inner line
map global normal "X" "gh<a-i><esc>: text-object-line<ret>"

# Select all occurances of current selection in file
map global normal "<a-*>" "*<percent>s<ret>" -docstring "Select all matching in file"

# Move while in insert mode
map global insert "ⓗ" "<left>"
map global insert "ⓙ" "<down>"
map global insert "<c-k>" "<up>"
map global insert "<c-l>" "<right>"

# Split selectios to indented block
# TODO: Make u a sub-mode of the user mode for utils
map global user "u" "<a-:><a-;>i<ret><esc><gt><space>;gli<ret><esc><lt>" -docstring "break to indent"

# <c-i> is the sane way to jump forward
map global normal <c-i> <tab>
