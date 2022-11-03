# NORMAL

# Selection history
map global normal <tab> <c-k>
map global normal <s-tab> <c-h>

# Comment
map global normal "#" ": comment-line<ret>"
map global normal "<a-#>" ": comment-block<ret>"

# Go to file (basic fuzzy finder)
map global goto "f" '<esc>: prompt -shell-script-candidates %{ fd --type f --hidden --no-ignore --exclude .git --exclude target --exclude .vscode/factorio } file: %{ edit %val{text} }<ret>' -docstring "file"

# Go to buffer
map global goto "b" '<esc>: prompt -buffer-completion buffer: %{ buffer %val{text} }<ret>' -docstring "buffer"

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

# Yank selections to system clipboard using OSC 52
map global normal "<c-y>" ": osc-yank<ret>"

# INSERT

# Delete words in insert mode
map global insert <c-backspace> "<esc>hBdi"
# Also delete when holding shift
map global insert <s-backspace> "<backspace>"

# USER

# Sort
declare-user-mode sort
map global user s ": enter-user-mode sort<ret>" -docstring "sort..."
map global sort l "|sort<ret>" -docstring "lines"
map global sort s "<esc>: sort-selections<ret>" -docstring "selections"

# Toggle
declare-user-mode toggle
map global user t ": enter-user-mode toggle<ret>" -docstring "toggle..."
map global toggle i ': show-tab-info<ret>' -docstring "tab settings"
define-command show-tab-info %{
    info -title "tab settings" "tabstop: %opt{tabstop}
softtabstop: %opt{softtabstop}
indentwidth: %opt{indentwidth}"
}
map global toggle s ': show-session-info<ret>' -docstring "session info"
define-command -hidden show-session-info %{
    info -title "session info" "%val{client}/%val{session}
%sh{pwd}"
}

# Wrap paragraphs
map global user w ": wrap-paragraph<ret>" -docstring "wrap paragraph"
define-command wrap-paragraph %{
    execute-keys "<a-i>p<a-j>|fold -s -w %opt{autowrap_column}<ret>"
}

# Git
declare-user-mode git
map global user g ": enter-user-mode git<ret>" -docstring "git..."
map global git b ": git blame<ret>" -docstring "blame"
map global git B ": git hide-blame<ret>" -docstring "hide blame"
map global git d ": git diff<ret>" -docstring "diff"
map global git g ": terminal-floating lazygit<ret>" -docstring "lazygit"
map global git l ": git log<ret>" -docstring "log"
map global git s ": git status<ret>" -docstring "status"

# Spell
declare-user-mode spell
map global user p ": enter-user-mode spell<ret>" -docstring "spell..."
map global spell a ": spell-add<ret>" -docstring "add"
map global spell c ": spell-clear<ret>" -docstring "clear"
map global spell p ": spell<ret>" -docstring "spell"
map global spell r ": spell-replace<ret>" -docstring "replace"
map global spell ] ": spell-next<ret>" -docstring "next"
