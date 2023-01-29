-- require("lspconfig").sumneko_lua.setup({
-- 	settings = {
-- 		Lua = {
-- 			runtime = {
-- 				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
-- 				version = "LuaJIT",
-- 			},
-- 			diagnostics = {
-- 				-- Get the language server to recognize the `vim` global
-- 				globals = { "vim" },
-- 			},
-- 			workspace = {
-- 				-- Make the server aware of Neovim runtime files
-- 				library = vim.api.nvim_get_runtime_file("", true),
-- 			},
-- 			-- Do not send telemetry data containing a randomized but unique identifier
-- 			telemetry = {
-- 				enable = false,
-- 			},
-- 		},
-- 	},
-- })

require("lspconfig").sumneko_lua.setup({
	-- on_attach = function()
	-- 	on_attach()
	-- 	vim.cmd([[autocmd BufWritePre <buffer> lua require'stylua-nvim'.format_file()]])
	-- end,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				-- path = runtime_path,
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
			},
			telemetry = {
				enable = false,
			},
		},
	},
})
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
-- lvim.lsp.on_attach_callback = function(client, bufnr)
-- 	require("lsp_signature").on_attach()
-- end
