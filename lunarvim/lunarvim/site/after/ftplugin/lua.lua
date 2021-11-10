require("lvim.lsp.manager").setup("sumneko_lua")
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({{exe = "stylua", filetypes = {"lua"} }})

local linters = require "lvim.lsp.null-ls.linters"
linters.setup({{exe = "selene", filetypes = {"lua"} }})
