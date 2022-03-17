fish_add_path "/home/rai/.local/bin"
fish_add_path "/home/rai/.cargo/bin"
fish_add_path "/home/rai/bin"

set -x KKS_USE_GITDIR_SESSIONS 1

set -x EDITOR "kks edit"
set -x PAGER "less"
set -x SHELL "fish"
set -x KAKOUNE_POSIX_SHELL "/bin/dash"

alias k "kks edit"
alias dlg "lazygit --work-tree ~/.dotfiles"
alias lg lazygit
alias fac1 /home/rai/dev/factorio/1/bin/x64/factorio
alias fac2 /home/rai/dev/factorio/2/bin/x64/factorio
alias facs-1.1 /home/rai/dev/projects/wube/Factorio-1.1/build/bin/Factorio_unity
alias facs-1.2 /home/rai/dev/projects/wube/Factorio-1.2/bin/Debugx64Clang/factorio-run
alias kbconfig "sh /home/rai/.config/keyboard.sh"
alias stw "stow --dir ~/.dotfiles --target ~/"
alias restart-kde "kquitapp5 plasmashell && kstart5 plasmashell"

source /usr/share/autojump/autojump.fish
