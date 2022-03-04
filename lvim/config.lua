-- Extra plugins
-- =========================================
require("user.additionalPlugins").config()

-- LSP
-- =========================================
-- require("lsp-config.general").config()

-- Customization
-- =========================================
-- require("user.autocommands")

-- user specific
-- =========================================
require("user.keybindings").config()
-- require("user.todoComments")
require("user.general").config()

-- Linter/Formatters
-- =========================================
-- require("lsp-config.lua")
-- require("lsp-config.bash")
-- require("lsp-config.rust")
-- require("lsp-config.svelte").config()
require("lsp-config.typescript").config()
-- require("lsp-config.javascript")
-- require("lsp-config.python")
-- require("lsp-config.markdown")
-- require("lsp-config.tailwindcss")
