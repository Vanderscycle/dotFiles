lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<A-t>"] = ":ToggleTerm<cr>"
lvim.keys.normal_mode["q"] = ""
lvim.keys.normal_mode["<leader>o"] = "o<Esc>" -- FIX THIS BINDING
lvim.keys.normal_mode["<leader>O"] = "0<Esc>"
lvim.keys.normal_mode["<S-x>"] = ":lua require('FTerm').toggle()<CR>"

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
