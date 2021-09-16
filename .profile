source "$HOME/.cargo/env"

# Screen layout
source "$HOME/.screenlayout/layout.sh"

# Because?
export EDITOR="kks edit"

# Make CapsLock behave like Ctrl:
setxkbmap -option ctrl:nocaps

# Make short-pressed Ctrl behave like Escape:
xcape -e 'Control_L=Escape'scape
