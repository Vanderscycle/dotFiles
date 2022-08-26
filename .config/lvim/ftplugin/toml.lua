local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "taplo",
		filetypes = { "toml" },
	},
})

-- none rn
-- local linters = require("lvim.lsp.null-ls.linters")
-- linters.setup({
-- 	{
-- 		exe = "taplo",
-- 		filetypes = { "toml" },
-- 	},
-- })
