local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "eslint_d",
		filetypes = { "typescript" },
		args = { "--double-quote" },
	},
})
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		exe = "eslint_d",
		filetypes = { "typescript" },
	},
})

-- local navic = require("nvim-navic")

-- require("lualine").setup({
-- 	sections = {
-- 		lualine_c = {
-- 			{ navic.get_location, cond = navic.is_available },
-- 		},
-- 	},
-- })
