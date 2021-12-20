-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- TODO: learn vim surround, vim-matchup, lazy-git and much more

--LSP
require("lsp-config.tailwindcss")

--TODO: fix selene stylua not beign found
-- require("lsp-config.lua")
require("lsp-config.typescript")
require("lsp-config.javascript")
require('lsp-config.svelte')

-- general
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "tokyonight"
vim.opt.relativenumber = true
--lvim.log.level = "debug"
-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymappin
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<A-t>"] = ":ToggleTerm<cr>"
lvim.keys.normal_mode["q"] = ""
--TODO: move the keys to which_key plugin
lvim.keys.normal_mode = {
	-- empowered searches
	["<leader>sT"] = ":Telescope current_buffer_fuzzy_find<cr>",
	["<leader>sF"] = ':lua require("telescope.builtin").find_files({hidden=true, no_ignore=true, find_command=rg})<cr>',
	["<leader>si"] = ":Telescope media_files<cr>",
  ["<leader>B"] = ":lua require 'telescope'.extensions.file_browser.file_browser()<CR>"
}
-- unmap a default keymappinig
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping

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
--INFO: telescope with nvim-bqf cool interaction with quickFix Lists
-- Search for text by calling <leader>st
-- you can then navigate between elementa using <C-J><C-K> and can start a selection by using <C-i>
-- if wanting all the fzf filtered results <C-q> (while in the telescope window) to send all to a quickFix list
-- if a selection was done previously then use <A-q> (while in the telescope window) to only send the items to a quickFix List
-- INFO: to toggle thet quickFix list use <A-q> while in normal mode to toggle the quickfixwind.
-- lsp integration can be had with folke/troule <Leader>td

--WARN: new command! You can use <A-j><A-k> to move line up and down!
-- INFO: usage trouble for its reference and all the bugs

-- Use which-key to add extra bindings with the leader-key prefix
-- BUG: known bug that when exiting the trouble quickfix window release to the wrong window
-- renbinded q
lvim.builtin.which_key.mappings["n"] = {
	name = "+package.json",
	s = { ":lua require('package-info').show()<cr>", "show outdated packages" },
	d = { ":lua require('package-info').delete()<cr>", "delete package" },
  p = {":lua require('package-info').change_version()<cr>", "change package version"},
  i = {":lua require('package-info').install()<cr>","install new package"},
  r = {":lua require('package-info').reinstall()<cr>", "reinstall package"}
}

--  lvim.builtin.which_key.mappings["s"]={
--   T = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "Trouble.nvim" },
-- }

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile

lvim.builtin.notify.active = true
lvim.builtin.notify.opts.background_colour = 'normal'
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
	"css",
	"dockerfile",
	"html",
	"javascript",
	"json",
	"svelte",
	"typescript",
	"yaml",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.keys.normal_mode["<S-x>"] = ":lua require('FTerm').toggle()<CR>"

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls seup table (useful for setting the root_dir function)
-- lvim.lsp.nul_ls.setup = {
--   root_dir = rquire("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- set a formatter if you want to override the default lsp one (if it exists)
-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--     args = {}
--   }
-- }
-- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8,
--     args = {}
--   }
-- }

-- Additional Plugins
lvim.plugins = {
	-- theme
	{ "folke/tokyonight.nvim" },
	{ "catppuccin/nvim" },
	{ "LunarVim/ColorSchemes" },
	--extra languages'
  -- WARN: install binaries
  --https://www.youtube.com/watch?v=MOaws1ozqNw
	-- { "ChristianChiarulli/vim-solidity" },
	-- lsp
	{
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
	},
	{
		"ray-x/navigator.lua",
		requires = { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
		config = function()
			vim.cmd("autocmd FileType guihua lua require('cmp').setup.buffer { enabled = false }")
			vim.cmd("autocmd FileType guihua_rust lua require('cmp').setup.buffer { enabled = false }")
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").setup()
		end,
	}, -- movement
	{
		"ggandor/lightspeed.nvim",
		event = "BufRead",
	},

	{
		"tpope/vim-surround",
		keys = { "c", "d", "y" },
	},
	{
		"andymass/vim-matchup",
		event = "CursorMoved",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	-- git
  {'kdheepak/lazygit.nvim'},
	-- windows (qickFix and peaking buffer)
	{
		"kevinhwang91/nvim-bqf",
		event = { "BufRead", "BufNew" },
		config = function()
			require("bqf").setup({
				auto_enable = true,
				preview = {
					win_height = 12,
					win_vheight = 12,
					delay_syntax = 80,
					border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
				},
				func_map = {
					vsplit = "",
					ptogglemode = "z,",
					stoggleup = "",
				},
				filter = {
					fzf = {
						action_for = { ["ctrl-s"] = "split" },
						extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
					},
				},
			})
		end,
	},
	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({
				width = 120, -- Width of the floating window
				height = 25, -- Height of the floating window
				default_mappings = true, -- Bind default mappings
				debug = false, -- Print debug information
				opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
				post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
				-- You can use "default_mappings = true" setup option
				-- Or explicitly set keybindings
				-- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
				-- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
				-- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
			})
		end,
	},
	-- better comment flags
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},
  --language specific
  --node
  {
    "vuki656/package-info.nvim",
    requires = "MunifTanjim/nui.nvim",
},
	-- telescope plugins
	{
		"nvim-telescope/telescope-fzy-native.nvim",
		run = "make",
		event = "BufRead",
	},
	{ "nvim-telescope/telescope-media-files.nvim" },
{ "nvim-telescope/telescope-file-browser.nvim" },
	--markdown
	-- You must install glow globally
	-- https://github.com/charmbracelet/glow
	-- yay -S glow
	{
		"npxbr/glow.nvim",
		ft = { "markdown" },
		-- run = "yay -S glow"
	},

	-- autoSave
	{
		"Pocco81/AutoSave.nvim",
		config = function()
			require("autosave").setup({ debounce_delay = 500 })
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		setup = function()
			vim.g.indentLine_enabled = 1
			vim.g.indent_blankline_char = "▏"
			vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
			vim.g.indent_blankline_buftype_exclude = { "terminal" }
			vim.g.indent_blankline_show_trailing_blankline_indent = false
			vim.g.indent_blankline_show_first_indent_level = false
		end,
	},
	-- {
	-- 	"tzachar/cmp-tabnine",
	-- 	config = function()
	-- 		local tabnine = require("cmp_tabnine.config")
	-- 		tabnine:setup({
	-- 			max_lines = 1000,
	-- 			max_num_results = 20,
	-- 			sort = true,
	-- 		})
	-- 	end,

	-- 	run = "./install.sh",
	-- 	requires = "hrsh7th/nvim-cmp",
	-- },
	-- misc
	-- refactoring plugin
	{
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	--WARN: still in active development plugin
	-- ssh into anything while using your local tools
	--   {
	--   'chipsenkbeil/distant.nvim',
	--   event = "DistantLaunch",
	--   config = function()
	--     require('distant').setup {
	--       -- Applies Chip's personal settings to every machine you connect to
	--       --
	--       -- 1. Ensures that distant servers terminate with no connections
	--       -- 2. Provides navigation bindings for remote directories
	--       -- 3. Provides keybinding to jump into a remote file's parent directory
	--       ['*'] = require('distant.settings').chip_default()
	--     }
	--   end
	-- }
	{
		"nvim-neorg/neorg",
		config = function()
			require("neorg").setup({
				-- Tell Neorg what modules to load
				load = {
					["core.defaults"] = {}, -- Load all the default modules
					["core.norg.concealer"] = {}, -- Allows for use of icons
					["core.norg.dirman"] = { -- Manage your directories with Neorg
						config = {
							workspaces = {
								my_workspace = "~/neorg",
							},
						},
					},
				},
			})
		end,
		requires = "nvim-lua/plenary.nvim",
	},
}
