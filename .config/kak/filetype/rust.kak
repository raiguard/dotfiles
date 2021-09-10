hook global WinSetOption filetype=rust %{
    # Enable language server
    lsp-init
    rainbow-enable-window

    # Format on save
    hook window BufWritePre .* lsp-formatting-sync

    # Inlay hints
    hook window -group rust-inlay-hints BufReload .* rust-analyzer-inlay-hints
    hook window -group rust-inlay-hints NormalIdle .* rust-analyzer-inlay-hints
    hook window -group rust-inlay-hints InsertIdle .* rust-analyzer-inlay-hints
    hook -once -always window WinSetOption filetype=.* %{
        rmhooks window rust-inlay-hints
    }
}
