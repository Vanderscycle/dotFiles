require("vsnip").setup{
    vim.g.vsnip_snippet_dir = '~/.local/share/nvim/site/pack/packer/start/friendly-snippets/snippets/'
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
}
