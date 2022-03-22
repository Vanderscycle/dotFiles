local M = {}
M.config = function ()


  local formatters = require("lvim.lsp.null-ls.formatters")
  formatters.setup({
    {
      exe = "prettier",
      filetypes = { "typescript" },
      args = { "--double-quote" },
    },
  })
  local linters = require("lvim.lsp.null-ls.linters")
  linters.setup({ { exe = "eslint", filetypes = { "typescript" } } })
end
return M
