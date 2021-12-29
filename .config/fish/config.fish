fish_add_path "/home/rai/.local/bin"
fish_add_path "/home/rai/.cargo/bin"
fish_add_path "/home/rai/bin"

set -x NNN_FCOLORS "0404040000000600010F0F02"

set -x KKS_USE_GITDIR_SESSIONS 1

set -x EDITOR "kks edit"

alias k "kks edit"
alias dlg "lazygit --work-tree ~/.dotfiles"
alias lg lazygit
alias fac1 /home/rai/dev/factorio/1/bin/x64/factorio
alias fac2 /home/rai/dev/factorio/2/bin/x64/factorio
alias kbconfig "sh /home/rai/.config/keyboard.sh"
alias stw "stow --dir ~/.dotfiles --target ~/"
alias restart-kde "kquitapp5 plasmashell && kstart5 plasmashell"

source /usr/share/autojump/autojump.fish
