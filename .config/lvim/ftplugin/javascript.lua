local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "eslint_d", --prettier
		filetypes = {
			"javascript",
			"javascriptreact",
			"vue",
			"svelte",
			"css",
			"scss",
			"less",
			"html",
			"json",
			"yaml",
			"markdown",
			"graphql",
		},
		args = { "--double-quote" },
	},
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		exe = "eslint_d",
		filetypes = {
			"javascript",
			"javascriptreact",
			"vue",
			"svelte",
		},
		args = { "--double-quote" },
	},
})
