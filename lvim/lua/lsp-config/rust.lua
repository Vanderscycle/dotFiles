local formatters = require("lvim.lsp.null-ls.linters")
formatters.setup({
	{
		exe = "rustfmt",
		filetypes = { "rust" },
	},
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		exe = "rust_analyser",
		filetypes = { "rust" },
	},
})
