local M = {}

M.config = function ()


  local formatters = require("lvim.lsp.null-ls.formatters")
  formatters.setup({
    {
      exe = "gofmt",
      filetypes = { "go" },
      -- args = { "--double-quote" },
    },
  })
  local linters = require("lvim.lsp.null-ls.linters")
  linters.setup({ { exe = "golangci_lint", filetypes = { "go" } } })
end
return M

