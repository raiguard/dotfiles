fish_add_path /home/rai/.config/kak/bin

set -x "blk" "04"
set -x "chr" "04"
set -x "dir" "04"
set -x "exe" "00"
set -x "reg" "00"
set -x "hardlink" "00"
set -x "symlink" "06"
set -x "missing" "00"
set -x "orphan" "01"
set -x "fifo" "0F"
set -x "sock" "0F"
set -x "other" "02"
set -x "NNN_FCOLORS" "$blk$chr$dir$exe$reg$hardlink$symlink$missing$orphan$fifo$sock$other"

set -x "KKS_USE_GITDIR_SESSIONS" 1
