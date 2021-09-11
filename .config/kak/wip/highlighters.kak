declare-option range-specs my_range

hook global WinCreate .* %{
    set-option global my_range %val{timestamp} "4.5,4.14|,,rgb:00aaff+u"
    add-highlighter window/ ranges my_range
}

