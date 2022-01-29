-- local formatters = require("lvim.lsp.null-ls.formatters")
-- formatters.setup({
-- 	{
-- 		exe = "prettier",
-- 		filetypes = { "markdown" },
-- 	},
-- })

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({ { exe = "write-good", filetypes = { "markdown" } } })
