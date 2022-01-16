hook global WinSetOption filetype=lua %{
    lsp-init
    rainbow-enable-window

    set-option window tabstop 2
    set-option window softtabstop 2
    set-option window indentwidth 2

    set-option window formatcmd "stylua -"
}
