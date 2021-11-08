require("lvim.lsp.manager").setup("tsserver")

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({{exe = "prettier", filetypes = {"typescript"} }})

local linters = require "lvim.lsp.null-ls.linters"
linters.setup({{exe = "eslint", filetypes = {"typecript"} }})
