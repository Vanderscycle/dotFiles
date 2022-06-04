local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		exe = "shellcheck",
		-- args = { "--severity", "warning" },
		filetypes = { "bash", "sh" },
	},
})
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "shfmt",
		filetypes = { "bash", "sh" },
	},
})
