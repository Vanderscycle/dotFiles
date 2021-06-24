-- load all plugins
-- highlights is first because I do not want it to overide my settings
require "highlights"
require "pluginsList.lua"
require "file-icons.lua"
require "misc-utils.lua"
require "bufferline.lua"
require "statusline.lua"

require("colorizer").setup()
require("neoscroll").setup() -- smooth scroll

-- lsp
require "lspconfig.lua"
require "compe.lua"

local cmd = vim.cmd
local g = vim.g

g.mapleader = " "
g.auto_save = 1

-- colorscheme related stuff

cmd "syntax enable"
cmd "syntax on"

local base16 = require "base16"
--base16(base16.themes["onedark"], true)
base16(base16.themes["nord"], true)
--base16(base16.themes["material-palenight"], true)

--indentline
g.indentLine_enabled = 1
g.indent_blankline_char = "▏"
g.indent_blankline_filetype_exclude = {"help", "terminal","dashboard"}
g.indent_blankline_buftype_exclude = {"terminal","dashboard"}
g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = false

require "treesitter.lua"
require "mappings.lua"

require "telescope.lua"
require "nvimTree.lua"

-- git signs
require "gitsigns.lua"

require("nvim-autopairs").setup()

require("lspkind").init(
    {
        with_text = true,
        symbol_map = {
            Folder = ""
        }
    }
)

-- hide line numbers in terminal windows
vim.api.nvim_exec([[
   au BufEnter term://* setlocal nonumber
]], false)

-- inactive statuslines as thin splitlines
cmd("highlight! StatusLineNC gui=underline guibg=NONE guifg=#383c44")

cmd "hi clear CursorLine"
cmd "hi cursorlinenr guibg=NONE guifg=#abb2bf"

-- setup for TrueZen.nvim
require "zen-mode.lua"

-- additions
require "dashboard.lua"
require "whichKey.lua"
require "todo-comments.lua"
-- lsps
require 'emmet.lua'
