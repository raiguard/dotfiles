# Syntax highlighting for Factorio changelog.txt files

hook global WinCreate (.*/|^)changelog\.txt %{
    # TODO: Validate this is a Factorio changelog by checking for info.json in the same directory
    set global filetype factorio-changelog
}

hook global WinSetOption filetype=factorio-changelog %{
    addhl window/changelog_date regex ^(Date):\s(.*?)$ 1:type 2:function
    addhl window/changelog_entry regex ^(\s\s)*(-)\s(.*?)$ 2:value 3:string
    addhl window/changelog_keyword regex ^\s*(Balancing|Bugfixes|Changes|Features|Gui|Info|Optimizations): 1:type
    addhl window/changelog_separator regex ^-+$ 0:keyword
    addhl window/changelog_version regex ^(Version):\s(\d+\.\d+\.\d+)$ 1:type 2:value
}
