hook global WinSetOption filetype=rainmeter %{
    rainbow-enable-window

    # Swap variable and operator colors
    face buffer variable "rgb:%opt{lightred}"
    face buffer operator default
}

hook global BufSetOption filetype=rainmeter %{
    set buffer comment_line ';'
}
