local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "null_ls",
		filetypes = { "typescript" },
		args = { "--double-quote" },
	},
})
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({ { exe = "eslint", filetypes = { "typescript" } } })
