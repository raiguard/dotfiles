provide-module todo %{
    def todo-enable %{
        hook global WinSetOption comment_line=(.*) %{
            addhl -override window/todo regex "\Q%val{hook_param_capture_1}\E\h*(TODO:)[^\n]*" 1:green
            addhl -override window/fixme regex "\Q%val{hook_param_capture_1}\E\h*(BUG:|FIXME:|HACK:|SLOW:|TEMPORARY:)[^\n]*" 1:red
            addhl -override window/note regex "\Q%val{hook_param_capture_1}\E\h*(NOTE:|PANIC:|SAFETY:)[^\n]*" 1:blue
        }

        def -docstring "add user mode mapping to grep for TODOs" todo-add-mapping %{
            map global user t ": grep (BUG:|FIXME:|HACK:|SLOW:|TEMPORARY:|TODO:)<ret>" -docstring "view TODOs"
        }
    }
}

