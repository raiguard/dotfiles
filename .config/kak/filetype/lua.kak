# For some reason, this file won't load unless we use @ instead of {}
hook global WinSetOption filetype=lua %@
    # FIXME: For some reason this breaks the other lua commands, don't know why
    # For now I just edited /usr/share/kak/rc/filetype/lua.kak directly
    # Better Lua syntax highlighting
    # remove-highlighter shared/lua

    # add-highlighter shared/lua regions
    # add-highlighter shared/lua/code default-region group
    # add-highlighter shared/lua/raw_string  region -match-capture '\[(=*)\['   '\](=*)\]'       fill string
    # add-highlighter shared/lua/raw_comment region -match-capture '--\[(=*)\[' '\](=*)\]'       fill comment
    # add-highlighter shared/lua/double_string region '"'   (?<!\\)(?:\\\\)*" fill string
    # add-highlighter shared/lua/single_string region "'"   (?<!\\)(?:\\\\)*' fill string
    # add-highlighter shared/lua/comment       region '--'  $                 fill comment

    # add-highlighter shared/lua/code/function_declaration regex \b(?:function\h+)(?:\w+\h*\.\h*)*([a-zA-Z_]\w*)\( 1:function
    # add-highlighter shared/lua/code/function_call regex \b([a-zA-Z_]\w*)\h*(?=[\(\{]) 1:function
    # add-highlighter shared/lua/code/keyword regex \b(break|do|else|elseif|end|for|function|goto|if|in|repeat|return|then|until|while)\b 0:keyword
    # add-highlighter shared/lua/code/value regex \b(false|nil|true|[0-9]+(:?\.[0-9])?(:?[eE]-?[0-9]+)?|0x[0-9a-fA-F])\b 0:value
    # add-highlighter shared/lua/code/operator regex (\+|-|\*|/|%|\^|==?|~=|<=?|>=?|\.\.|\.\.\.|#) 0:operator
    # add-highlighter shared/lua/code/operator_word regex \b(and|not|or)\b 0:operator
    # add-highlighter shared/lua/code/builtin regex \b(_G|_E)\b 0:builtin
    # add-highlighter shared/lua/code/module regex \b(_G|_E)\b 0:module
    # add-highlighter shared/lua/code/attribute regex \b(local)\b 0:attribute

    # Configure lua language server
    # set global lsp_server_configuration 'Lua.diagnostics.disable=["lowercase-global"]'
    # set -add global lsp_server_configuration 'Lua.diagnostics.globals=["__DebugAdapter","__Profiler","bit32","commands","data","defines","game","global","localised_print","log","mods","on_error","rcon","remote","rendering","script","serpent","settings","table_size"]'

    lsp-init
    rainbow-enable-window

    set window tabstop 2
    set window softtabstop 2
    set window indentwidth 2

    addhl window/ column 121 "default,rgb:%opt{subbg}"

    # set window formatcmd stylua
    # hook window BufWritePre .* format
@
