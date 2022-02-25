local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		exe = "shellcheck",
		args = { "--severity", "warning" },
		filetypes = { "bash" },
	},
})
