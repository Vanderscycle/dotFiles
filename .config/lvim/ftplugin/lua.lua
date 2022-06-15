local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({ { exe = "stylua" } })

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		exe = "luacheck",
		cwd = function(params) -- force luacheck to find its '.luacheckrc' file
			local u = require("null-ls.utils")
			return u.root_pattern(".luacheckrc")(params.bufname)
		end,
	},
})

local navic = require("nvim-navic")

require("lualine").setup({
	sections = {
		lualine_c = {
			{ navic.get_location, cond = navic.is_available },
		},
	},
})
