local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  {
    exe = "hadolint",
    filetypes = { "dockerfile" },
  },
})
