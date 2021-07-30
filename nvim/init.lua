
require "pluginList"
require "theme"
require "misc-utils"
require "bufferline"
local g = vim.g

g.mapleader = " "
g.auto_save = true

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
