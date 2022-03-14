local M = {}

M.config = function()
  lvim.plugins = {
    -- themes
    { "folke/tokyonight.nvim" },
    { "LunarVim/ColorSchemes" },

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
    -- movement
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
      "sidebar-nvim/sidebar.nvim",
      config = function()
        require("plugins.sidebar").config()
      end,
      event = "BufRead",
      -- disable = not lvim.builtin.sidebar.active, -- TODO: activation
    },
    {
      "kosayoda/nvim-lightbulb",
      config = function()
        vim.fn.sign_define(
          "LightBulbSign",
          { text = require("user.lsp_kind").icons.code_action, texthl = "DiagnosticInfo" }
        )
      end,
      event = "BufRead",
      ft = { "rust", "go", "typescript", "typescriptreact" },
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
    { "kdheepak/lazygit.nvim" },
    -- search
    -- TODO: replace greeper with something better
    { "mhinz/vim-grepper" },
    -- windows (qickFix and peaking buffer)
        {
      "kevinhwang91/nvim-bqf",
      config = function()
        require("plugins.bqf").config()
      end,
      event = "BufRead",
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
          dismiss_on_move = true,
          -- You can use "default_mappings = true" setup option
          -- Or explicitly set keybindings
          vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>"),
          vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>"),
          vim.cmd("nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>"),
          vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>"),
        })
        --gd gpd gD gpR leader + l + d/r/i
        --TODO: remove the extra bindings
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
        require("autosave").setup({ debounce_delay = 125 })
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
    { "tzachar/cmp-tabnine", run = "./install.sh", requres = "hrsh7th/nvim-cmp" },
    -- misc
    --WARN: still in active development plugin
    {
      "ThePrimeagen/refactoring.nvim",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
      },
    },

    {
      "David-Kunz/cmp-npm",
      requires = {
        "nvim-lua/plenary.nvim",
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
	-- {
	-- 	"nvim-neorg/neorg",
	-- 	config = function()
	-- 		require("neorg").setup({
	-- 			-- Tell Neorg what modules to load
	-- 			load = {
	-- 				["core.defaults"] = {}, -- Load all the default modules
	-- 				["core.norg.concealer"] = {}, -- Allows for use of icons
	-- 				["core.norg.dirman"] = { -- Manage your directories with Neorg
	-- 					config = {
	-- 						workspaces = {
	-- 							my_workspace = "~/neorg",
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- 	requires = "nvim-lua/plenary.nvim",
	-- },
	--extra languages'
	-- { "h-hg/fcitx.nvim" }, --chinese input
