local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  {
    exe = "jq",
    filetypes = { "json" },
  },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  {
    exe = "jsonlint",
    filetypes = { "json" },
  },
})
