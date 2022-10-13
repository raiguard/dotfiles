export EDITOR="kak"
export PAGER="less"
export KAKOUNE_POSIX_SHELL=/bin/dash

export PATH="$HOME/bin/$HOSTNAME:$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
export MOZ_ENABLE_WAYLAND=1
export QT_PLATFORM_THEME=qt5ct
export QT_QPA_PLATFORMTHEME=qt5ct

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# FZF config
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
'

# Make Java applications work correctly (pycharm)
export _JAVA_AWT_WM_NONREPARENTING=1

[[ -f ~/.env ]] && . ~/.env
[[ -f ~/.bashrc ]] && . ~/.bashrc

# If running from tty1 start sway
[ "$(tty)" = "/dev/tty1" ] && exec sway
