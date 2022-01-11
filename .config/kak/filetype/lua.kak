hook global WinSetOption filetype=lua %{
    lsp-init
    rainbow-enable-window

    set window tabstop 2
    set window softtabstop 2
    set window indentwidth 2

    set window formatcmd "stylua -"
}
