hook global WinSetOption filetype=mail %{
    set-option global autowrap_column 72
    set-option global autowrap_format_paragraph true
    autowrap-enable
}
