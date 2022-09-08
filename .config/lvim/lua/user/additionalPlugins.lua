local M = {}
M.config = function()
	lvim.plugins = {
		-- { "rafcamlet/nvim-whid" }, -- TEST remnove later
		{ "j-hui/fidget.nvim" }, --WARN: working?
		-- note taking
		{ "renerocksai/calendar-vim" }, -- TODO: needs binding and spawn on the right
		{
			"renerocksai/telekasten.nvim",
			requires = "renerocksai/calendar-vim",
			config = function()
				require("plugins.telekasten").config()
			end,
		},
		-- themes
		{
			"folke/tokyonight.nvim",
			config = function()
				require("plugins.tokyonight").config()
			end,
		},
		{ "LunarVim/ColorSchemes" },
		{
			"simrat39/symbols-outline.nvim",
			cmd = "SymbolsOutline",
		},
		{
			"ray-x/lsp_signature.nvim",
			config = function()
				require("plugins.signature").config()
			end,
			event = { "BufRead", "BufNew" },
		},
		{
			"ggandor/lightspeed.nvim",
			event = "BufRead",
			config = function()
				require("plugins.lightspeed").config()
			end,
			disable = lvim.builtin.motion_provider ~= "lightspeed",
		},
		-- visual aid
		-- { "edluffy/hologram.nvim" }, -- needs a toggle binding
		{
			"SmiteshP/nvim-navic",
			requires = "neovim/nvim-lspconfig",
			config = function()
				require("plugins.navic").config()
			end,
		},
		{
			"mrshmllow/document-color.nvim",
			config = function()
				require("document-color").setup({
					-- Default options
					mode = "background", -- "background" | "foreground"
				})
			end,
		},
		{ "norcalli/nvim-colorizer.lua" },
		{
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
			-- todo: move to plugin file
			config = function()
				require("lsp_lines").setup()
				vim.diagnostic.config({
					virtual_text = false,
				})
				--	require("lsp_lines").register_lsp_virtual_lines()
				-- 	lvim.builtin.which_key.mappings["lL"] =
				-- 		{ require("lsp_lines").toggle, { desc = "Toggle lsp_lines" }, "lsp_lines" }
			end,
		},
		{
			"mvllow/modes.nvim",
			config = function()
				require("plugins.modes").config()
			end,
			event = "BufRead",
		},
		{
			"sidebar-nvim/sidebar.nvim",
			config = function()
				require("plugins.sidebar").config()
			end,
			event = "BufRead",
			-- disable = not lvim.builtin.sidebar.active, -- TODO: activation
		},
		{
			"npxbr/glow.nvim",
			ft = { "markdown" },
			config = function()
				require("plugins.glow").config()
			end,
			-- run = "yay -S glow"
		},
		-- utility
		{
			"filipdutescu/renamer.nvim",
			branch = "master",
			requires = { "nvim-lua/plenary.nvim" },
		},
		{
			"kylechui/nvim-surround",
			config = function()
				require("nvim-surround").setup({
					-- Configuration here, or leave empty to use defaults
				})
			end,
		},
		{
			"andymass/vim-matchup",
			event = "CursorMoved",
			config = function()
				vim.g.matchup_matchparen_offscreen = { method = "popup" }
			end,
		},
		-- git
		{ "kdheepak/lazygit.nvim" },
		{
			"f-person/git-blame.nvim",
			config = function()
				vim.g.gitblame_ignored_filetypes = { "nvim-tree" }
				-- 	vim.g.gitblame_highlight_group = { "#ff9e64" }
			end,
		},
		{ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }, --WARN: required anymore since lazygit??
		-- search
		{
			"nacro90/numb.nvim",
			config = function()
				require("plugins.numb").config()
			end,
			event = "BufRead",
		},
		{
			"kevinhwang91/nvim-bqf",
			requires = "junegunn/fzf",
			config = function()
				require("plugins.bqf").config()
			end,
			event = "BufRead",
		},
		{
			"junegunn/fzf",
			run = function()
				vim.fn["fzf#install"]()
			end,
		},
		-- better comment flags
		{
			"folke/todo-comments.nvim",
			event = "BufRead",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("plugins.todoComments").config()
			end,
		},
		-- telescope plugins
		-- TODO: how to add them to the telescope
		-- {
		-- 	"nvim-telescope/telescope-fzy-native.nvim",
		-- 	run = "make",
		-- 	event = "BufRead",
		-- },
		{ "nvim-telescope/telescope-symbols.nvim" },
		{
			"nvim-telescope/telescope-media-files.nvim",
		},
		{
			"nvim-telescope/telescope-file-browser.nvim",
		},
		-- autoSave
		-- {
		-- 	"Pocco81/AutoSave.nvim",
		-- 	config = function()
		-- 		require("plugins.autosave").config()
		-- 	end,
		-- },
		{
			"lukas-reineke/indent-blankline.nvim",
			setup = function()
				vim.g.indent_blankline_char = "▏"
			end,
			config = function()
				require("plugins.indent_blankline").config()
			end,
			event = "BufRead",
		},
		{
			"kevinhwang91/nvim-hlslens",
			config = function()
				require("plugins.hlslens").config()
			end,
			event = "BufReadPost",
			-- disable = not lvim.builtin.hlslens.active,
		},
		{
			"tzachar/cmp-tabnine",
			run = "./install.sh",
			requires = "hrsh7th/nvim-cmp",
			config = function()
				require("plugins.tabnine").config()
			end,
			event = "InsertEnter",
			-- disable = not lvim.builtin.tabnine.active,
		},
		{
			"David-Kunz/cmp-npm",
			requires = {
				"nvim-lua/plenary.nvim",
			},
		},
		{
			"chipsenkbeil/distant.nvim",
			config = function()
				require("plugins.distant").config()
			end,
		},
		-- refactoring (requires config)
		-- https://github.com/ThePrimeagen/harpoon
		{
			"ThePrimeagen/harpoon",
			requires = { "nvim-lua/plenary.nvim" },
		},
		{
			"ThePrimeagen/refactoring.nvim",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-treesitter/nvim-treesitter" },
			},
		},
	}
end

return M
-- not ready
-- =========================================
-- INFO: ssh into anything while using your local tools
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
---extra languages'
-- { "h-hg/fcitx.nvim" }, --chinese input
--       -- misc
--WARN: still in active development plugin
-- {
--   "ThePrimeagen/refactoring.nvim",
--   requires = {
--     { "nvim-lua/plenary.nvim" },
--     { "nvim-treesitter/nvim-treesitter" },
--   },
-- },
