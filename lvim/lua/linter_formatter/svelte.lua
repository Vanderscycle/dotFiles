local M = {}
M.config = function ()

  local formatters = require("lvim.lsp.null-ls.formatters")
  formatters.setup({
    {
      exe = "prettier",
      filetypes = { "svelte" },
      -- command = "./node_modules/.bin/prettier",
      args = { "--double-quote" },
    },
  })

  local linters = require("lvim.lsp.null-ls.linters")
  linters.setup({
    {
      exe = "eslint",
      filetypes = { "svelte" },
    },
  })
end

return M
