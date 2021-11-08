require("lvim.lsp.manager").setup("gopls")

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({{exe = "gopls", filetypes = {"go"} }})

local linters = require "lvim.lsp.null-ls.linters"
linters.setup({{exe = "gofmt", filetypes = {"go"} }})
