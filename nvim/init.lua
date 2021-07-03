-- load all plugins
require "pluginList"
require "misc-utils"
require "top-bufferline"

local g = vim.g

g.mapleader = " "
g.auto_save = false

-- colorscheme related stuff

--g.nvchad_theme = "onedark"
local base16 = require "base16"
--base16(base16.themes["onedark"], true)
g.nvchad_theme = "nord"
base16(base16.themes["nord"], true)

require "highlights"
require "mappings"
require "file-icons"
require "statusline"

-- hide line numbers , statusline in specific buffers!
vim.api.nvim_exec(
    [[
   au BufEnter term://* setlocal nonumber
   au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
   au BufEnter term://* set laststatus=0 
]],
    false
)
--user added
require 'lsp_signature'.on_attach()
--TODO: get emmet-ls working
