hook global WinSetOption filetype=rust %{
    set global lsp_server_configuration 'rust.clippy_reference="off"'
    lsp-init
    rainbow-enable-window

    # Format on save
    hook window BufWritePre .* lsp-formatting-sync
    # Clippy
    # TODO: Doesn't do anything?
    # set window lsp_server_configuration rust.clippy_preference="on"

    # Inlay hints
    hook window -group rust-inlay-hints BufReload .* rust-analyzer-inlay-hints
    hook window -group rust-inlay-hints NormalIdle .* rust-analyzer-inlay-hints
    hook window -group rust-inlay-hints InsertIdle .* rust-analyzer-inlay-hints
    hook -once -always window WinSetOption filetype=.* %{
        rmhooks window rust-inlay-hints
    }
}
