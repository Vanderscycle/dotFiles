local M = {}
M.config = function()
	lvim.plugins = {
		{ "rafcamlet/nvim-whid" }, -- TEST remnove later
		-- themes
		{ "folke/tokyonight.nvim" },
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
		{ --INFO: used?
			"kosayoda/nvim-lightbulb",
			config = function()
				require("plugins.lightbulb").config()
				-- vim.fn.sign_define(
				-- 	"LightBulbSign",
				-- 	{ text = require("user.lsp_kind").icons.code_action, texthl = "DiagnosticInfo" }
				-- )
			end,
			event = "BufRead",
			ft = { "rust", "go", "typescript", "typescriptreact" },
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
		-- {
		-- 	"luukvbaal/nnn.nvim",
		-- 	config = function()
		-- 		require("nnn").setup()
		-- 	end,
		-- },
		{
			"smjonas/inc-rename.nvim",
			config = function()
				require("inc_rename").setup()
				-- require("plugins.inc_rename").config()
			end,
			event = "BufRead",
		},
		{
			"tpope/vim-surround",
			keys = { "c", "d", "y" },
			event = "BufRead",
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
		{
			"nvim-telescope/telescope-fzy-native.nvim",
			run = "make",
			event = "BufRead",
		},
		-- { "nvim-telescope/telescope-media-files.nvim" }, --WARN: not working
		{ "nvim-telescope/telescope-file-browser.nvim" },
		-- autoSave
		{
			"Pocco81/AutoSave.nvim",
			config = function()
				require("autosave").setup({ debounce_delay = 125 })
			end,
		},
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
