# For some reason, this file won't load unless we use @ instead of {}
hook global WinSetOption filetype=lua %{
    lsp-init
    rainbow-enable-window

    set window tabstop 2
    set window softtabstop 2
    set window indentwidth 2

    addhl window/ column 121 "default,rgb:%opt{subbg}"

    set window formatcmd "stylua -"
}
