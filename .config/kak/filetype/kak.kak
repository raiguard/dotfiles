hook global WinSetOption filetype=kak %{
    rainbow-enable-window
}

# Enable kak features on .kakrc files as well
hook global BufCreate (.*/)?(\.kakrc) %{
    set-option buffer filetype kak
}
