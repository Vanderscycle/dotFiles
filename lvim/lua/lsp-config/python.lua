-- vim.cmd([[setlocal shiftwidth=4]])
-- vim.cmd([[setlocal tabstop=4]])

-- lvim.lang.python.format_on_save = false
lvim.autocommands.custom_groups = {
	-- On entering a lua file, set the tab spacing and shift width to 8
	{ "BufWinEnter", "*.py", "setlocal ts=4 sw=4" },
	-- { "BufWinEnter", "*.py", "lvim.autosave = false" },
}
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "black",
		filetypes = { "python" },
	},
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		exe = "flake8",
		filetypes = { "python" },
	},
})
