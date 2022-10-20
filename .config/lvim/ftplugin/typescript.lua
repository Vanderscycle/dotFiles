require("lvim.lsp.manager").setup("typescript")
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "eslint_d",
		filetypes = {
			"typescript",
			"typescriptreact",
			"svelte",
		},
		-- args = { "--double-quote", "--fix" },
	},
})
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		exe = "eslint_d",
		filetypes = {
			"typescript",
			"typescriptreact",
			"svelte",
		},
		-- args = { "--double-quote", "--fix" },
	},
})
-- quotes: ["error", "double", { "avoidEscape": true }]
