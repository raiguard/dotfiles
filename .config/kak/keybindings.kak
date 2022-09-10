# NORMAL

# Comment
map global normal "#" ": comment-line<ret>"
map global normal "<a-#>" ": comment-block<ret>"

# Go to file (basic fuzzy finder)
map global goto "f" '<esc>: prompt -shell-script-candidates %{ fd --type f --hidden --exclude ".git" --no-ignore } file: %{ edit %val{text} }<ret>' -docstring "file"

# Go to buffer
map global goto "b" '<esc>: prompt -buffer-completion buffer: %{ buffer %val{text} }<ret>' -docstring "buffer"

# Git client
map global view "g" "<esc>: terminal-floating lazygit<ret>" -docstring "lazygit..."

# Pick file with NNN
map global normal <minus> ': terminal-floating nnn-pick %val{buffile} %val{client} %val{session}<ret>'

# Search case-insensitive by default
map global normal "/" "/(?i)"
map global normal "?" "?(?i)"
map global normal "<a-/>" "<a-/>(?i)"
map global normal "<a-?>" "<a-?>(?i)"

# Always select entire lines
map global normal J "Jx"
map global normal K "Kx"

# Select inner line
map global normal X "giGl" -docstring "Select inner line"

# Select all occurances of current selection in file
map global normal "<a-*>" "*<percent>s<ret>" -docstring "Select all matching in file"

# INSERT

# Delete words in insert mode
map global insert <c-backspace> "<esc>hBdi"
# Also delete when holding shift
map global insert <s-backspace> "<backspace>"

# USER

# System clipboard integration
declare-option -hidden str copy_cmd "wl-copy"
declare-option -hidden str paste_cmd "wl-paste"
map global user p "<a-!>%opt{paste_cmd}<ret>" -docstring 'Paste system clipboard (after)'
map global user P "!%opt{paste_cmd}<ret>" -docstring 'Paste system clipboard(before)'
map global user y "<a-|>%opt{copy_cmd}<ret>:echo -markup %%{{Information}Copied primary selection to system clipboard}<ret>" -docstring 'Yank to system clipboard'
map global user R "|%opt{paste_cmd}<ret>" -docstring 'Replace from system clipboard'

# Sort
declare-user-mode sort
map global user s ": enter-user-mode sort<ret>" -docstring "sort..."
map global sort l "|sort<ret>" -docstring "lines"
map global sort s "<esc>: sort-selections<ret>" -docstring "selections"

# Toggle
declare-user-mode toggle
map global toggle s ': info "%val{client}/%val{session}"<ret>' -docstring "session info"
map global user t ": enter-user-mode toggle<ret>" -docstring "toggle..."
