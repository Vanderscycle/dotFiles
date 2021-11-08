require("lvim.lsp.manager").setup("solang")

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({{exe = "prettier", filetypes = {"solidity"} }})
