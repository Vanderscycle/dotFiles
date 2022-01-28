local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "jsonls",
		filetypes = { "json" },
	},
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({ { exe = "prettier", filetypes = { "json" } } })
