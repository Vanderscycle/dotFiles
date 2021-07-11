-- load all plugins
require "pluginList"
require "misc-utils"
require "top-bufferline"

local g = vim.g

g.mapleader = " "
g.auto_save = true

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
vim.cmd [[autocmd BufReadPost,FileReadPost lua require "lsp_signature".on_attach()]]
require 'lspsaga_config'
--user added
--TODO: get emmet-ls working
--TODO: figure out more about global quickfixlist :vimgrep (what) (where) -- you can do **/*.lua for example
--TODO: figure out more about local quickfixlist :lgrep (what {word under cursor}) (location {this buffer})
--TODO: figure out about :ldo e.g. :ldo g/function/norm! Ilocal https://neovim.io/doc/user/quickfix.html#:ldo
