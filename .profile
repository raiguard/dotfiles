export EDITOR="kks edit"
export PAGER="less"
export KKS_USE_GITDIR_SESSIONS=1
export KAKOUNE_POSIX_SHELL=/bin/dash

export PATH="$HOME/bin:$HOME/.cargo/bin:$PATH"
export MOZ_ENABLE_WAYLAND=1
export QT_PLATFORM_THEME=qt5ct
export QT_QPA_PLATFORMTHEME=qt5ct

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

[[ -f ~/.env ]] && . ~/.env
[[ -f ~/.bashrc ]] && . ~/.bashrc

# If running from tty1 start sway
[ "$(tty)" = "/dev/tty1" ] && exec sway
