hook global BufCreate (.*/|^)changelog\.txt %{
    # TODO: Validate this is a Factorio changelog by checking for info.json in the same directory
    set-option buffer filetype factorio-changelog
}

hook global WinSetOption filetype=factorio-changelog %{
    # Highlighters
    add-highlighter window/changelog_date regex ^(Date):\s(.*?)$ 1:type 2:function
    add-highlighter window/changelog_entry regex ^(\s\s)*(-)\s(.*?)$ 2:value 3:string
    add-highlighter window/changelog_keyword regex ^\s*(Balancing|Bugfixes|Changes|Features|Gui|Info|Optimizations): 1:type
    add-highlighter window/changelog_separator regex ^-+$ 0:keyword
    add-highlighter window/changelog_version regex ^(Version):\s(\d+\.\d+\.\d+)$ 1:type 2:value

    # Two-space indents
    set-option window tabstop 2
    set-option window softtabstop 2
    set-option window indentwidth 2
}
