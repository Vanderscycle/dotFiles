require("vimspector").setup {
    vim.g.vimspector_enable_mappings = "HUMAN"
    vim.g.vimspector_install_gadgets = [ 'debugpy', 'vscode-go', 'CodeLLDB', 'vscode-node-debug2' ]
}
