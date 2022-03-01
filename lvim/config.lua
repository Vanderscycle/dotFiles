-- require("lsp-config.tailwindcss")
--TODO: fix selene stylua not beign found
require("plugins.default")
require("lsp-config.lua")
require("lsp-config.bash")
-- require("plugins.wilder")
-- require("ftplugin.typescript")
require("lsp-config.typescript")
require("lsp-config.javascript")
-- require("lsp-config.svelte")
require("lsp-config.python")
require("lsp-config.markdown")
-- require("lsp-config.tailwindcss")
-- require("lspconfig").tailwindcss.setup({})

lvim.autocommands.custom_groups = {
	-- On entering insert mode in any file, scroll the window so the cursor line is centered
	{ "InsertEnter", "*", ":normal zz" },
	-- {"","*", ":<Esc>" }
}
-- general

-- lvim.autosave = true
lvim.format_on_save = true
-- lvim.lint_on_save = true

lvim.colorscheme = "tokyonight"
vim.opt.relativenumber = true
vim.opt.wrap = true
--lvim.log.level = "debug"
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<A-t>"] = ":ToggleTerm<cr>"
lvim.keys.normal_mode["q"] = ""
lvim.keys.normal_mode["<leader>o"] = "o<Esc>" -- FIX THIS BINDING
lvim.keys.normal_mode["<leader>O"] = "0<Esc>"

--TODO: move the keys to which_key plugin
lvim.keys.normal_mode = {
	-- empowered searches
	["<leader>sT"] = ":Telescope current_buffer_fuzzy_find<cr>",
	["<leader>sF"] = ':lua require("telescope.builtin").find_files({hidden=true, no_ignore=true, find_command=rg})<cr>',
	["<leader>si"] = ":Telescope media_files<cr>",
	["<leader>sn"] = ":lua require 'telescope'.extensions.file_browser.file_browser()<CR>", --nnn nexttime?
	["<leader>bt"] = ":Telescope buffers<CR>",
}

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
local actions = require("telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
	i = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<C-n>"] = actions.cycle_history_next,
		["<C-p>"] = actions.cycle_history_prev,
	},
	n = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
	},
}
lvim.builtin.which_key.mappings["n"] = {
	name = "+package.json",
	s = { ":lua require('package-info').show()<cr>", "show outdated packages" },
	d = { ":lua require('package-info').delete()<cr>", "delete package" },
	p = { ":lua require('package-info').change_version()<cr>", "change package version" },
	i = { ":lua require('package-info').install()<cr>", "install new package" },
	r = { ":lua require('package-info').reinstall()<cr>", "reinstall package" },
}

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile

lvim.builtin.notify.active = true
lvim.builtin.notify.opts.background_colour = "normal"
lvim.builtin.cmp.completion.keyword_length = 2
lvim.lsp.automatic_servers_installation = true
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.autopairs.active = true
lvim.builtin.terminal.active = true
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"python",
	"lua",
	"bash",
	"dockerfile",
	"html",
	"javascript",
	"json",
	"svelte",
	"typescript",
	"yaml",
	"fish",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.keys.normal_mode["<S-x>"] = ":lua require('FTerm').toggle()<CR>"
