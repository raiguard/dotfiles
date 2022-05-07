hook global WinSetOption filetype=rust %{
    # Enable language server
    lsp-init
    rainbow-enable-window

    # Format on save
    hook window BufWritePre .* lsp-formatting-sync
}
