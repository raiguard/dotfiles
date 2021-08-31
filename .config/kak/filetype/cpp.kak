hook global WinSetOption filetype=(c|cpp) %{
    lsp-init
    rainbow-enable-window

    # Highlight operators
    try %{
        remove-highlighter buffer/operators
        add-highlighter    buffer/operators regex (\+|-|\*|&|=|\\|\?|%|\|-|!|\||->|\.|,|<|>|:|\^|/|~|\[|\]) 0:operator
    }
    try %{
        remove-highlighter buffer/delimiters
        add-highlighter    buffer/delimiters regex (\(|\)||\{|\}|\;|'|`) 0:delimiter
    }
}

# Better syntax highlighting
hook global ModuleLoaded c-family %{
    try %{ evaluate-commands %sh{
        join() { sep=$2; eval set -- $1; IFS="$sep"; echo "$*"; }

        # taken from rc/filetype/c-family.kak
        c_keywords='asm break case continue default do else for goto if return
                    sizeof switch while offsetof alignas alignof'
        # Highlight functions ignoring C specific keywords
        printf "%s\n" "add-highlighter shared/c/code/my_functions regex (\w*?)\b($(join '${c_keywords}' '|'))?(\h+)?(?=\() 1:function"
        # taken from rc/filetype/c-family.kak
        cpp_keywords='alignas alignof and and_eq asm bitand bitor break case catch
                      compl const_cast continue decltype delete do dynamic_cast
                      else export for goto if new not not_eq operator or or_eq
                      reinterpret_cast return sizeof static_assert static_cast switch
                      throw try typedef typeid using while xor xor_eq'
        # Highlight functions ignoring C++ specific keywords
        printf "%s\n" "add-highlighter shared/cpp/code/functions regex (\w*?)\b($(join '${cpp_keywords}' '|'))?(\h+)?(?=\() 1:function"
        # Namespace highlighting
        printf "%s\n" "add-highlighter shared/cpp/code/namespace  regex [a-zA-Z](\w+)?(\h+)?(?=::) 0:module"
        # Types and common highlightings. Same for C and C++
        for filetype in c cpp; do
            printf "%s\n" "add-highlighter shared/$filetype/code/my_field   regex ((?<!\.\.)(?<=\.)|(?<=->))[a-zA-Z](\w+)?\b(?![>\"\(]) 0:meta
                           add-highlighter shared/$filetype/code/my_method  regex ((?<!\.\.)(?<=\.)|(?<=->))[a-zA-Z](\w+)?(\h+)?(?=\() 0:function
                           add-highlighter shared/$filetype/code/my_return  regex \breturn\b 0:keyword
                           add-highlighter shared/$filetype/code/my_types_1 regex \b(v|u|vu)\w+(8|16|32|64)(_t)?\b 0:type
                           add-highlighter shared/$filetype/code/my_types_2 regex \b(v|u|vu)?(_|__)?(s|u)(8|16|32|64)(_t)?\b 0:type
                           add-highlighter shared/$filetype/code/my_types_3 regex \b(v|u|vu)(_|__)?(int|short|char|long)(_t)?\b 0:type
                           add-highlighter shared/$filetype/code/my_types_4 regex \b\w+_t\b 0:type"
        done
    }}
}
