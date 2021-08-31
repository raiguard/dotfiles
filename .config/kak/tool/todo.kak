hook global WinSetOption comment_line=(.*) %{
    addhl -override window/todo regex "\Q%val{hook_param_capture_1}\E\h*(TODO:)[^\n]*" 1:green
    addhl -override window/fixme regex "\Q%val{hook_param_capture_1}\E\h*(BUG:|FIXME:|HACK:|SLOW:|TEMPORARY:|WORKAROUND:)[^\n]*" 1:red
    addhl -override window/note regex "\Q%val{hook_param_capture_1}\E\h*(NOTE:|PANIC:|SAFETY:)[^\n]*" 1:blue
}

map global user t ": grep (BUG:|FIXME:|TODO:)<ret>" -docstring "view TODOs"

