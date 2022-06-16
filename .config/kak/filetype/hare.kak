hook global WinSetOption filetype=hare %{
    rainbow-enable-window

    set-option window tabstop 8
    set-option window softtabstop 8
    set-option window indentwidth 8

    add-highlighter shared/hare/code/operator regex "(=|\+|-|\*|/|<|>|;|:|!|\?|,|&|\.\.\.)" 0:operator
    add-highlighter shared/hare/code/function regex "\b(\w*)\(" 1:function
    add-highlighter shared/hare/code/moduleuse regex "\b(\w*)::" 1:module
    set-face global meta keyword
}
