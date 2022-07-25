local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "prettier",
		filetypes = { "markdown" },
	},
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		exe = "vale",
		filetypes = { "markdown" },
	},
	{
		exe = "write_good",
		filetypes = { "markdown" },
	},
})

vim.cmd([[setlocal nospell]])
vim.cmd([[setlocal conceallevel=2]])
-- vim.list_extend(lvim.lsp.override, { "ltex", "tailwindcss" })
