hook global WinSetOption filetype=typescript %{
    # Enable language server
    lsp-init
    rainbow-enable-window

    # Format on save
    hook window BufWritePre .* lsp-formatting-sync

    # TODO: NPM shortcuts
}

