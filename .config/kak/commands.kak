def edit-kakrc %{ e ~/.config/kak/kakrc }

def ide -params 0..1 %{
    try %{ rename-session %arg{1} }

    rename-client main
    set global jumpclient main

    new rename-client tools
    set global toolsclient tools

    new rename-client docs
    set global docsclient docs
}
