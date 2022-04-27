local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "prettier",
		filetypes = { "haskell" },
	},
})
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({ { exe = "hlint", filetypes = { "haskell" } } })
