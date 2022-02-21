local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "prettier",
		filetypes = { "svelte" },
		args = { "--double-quote" },
	},
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		exe = "eslint",
		filetypes = { "svelte" },
	},
})

-- local tailwindcss = require("lsp-config.tailwindcss")

-- if tailwindcss.project_has_tailwindcss_dependency() == true then
-- 	require("lvim.lsp.manager").setup("tailwindcss")
-- else
-- 	vim.list_extend(lvim.lsp.override, { "tailwindcss", "svelte" })
-- end
