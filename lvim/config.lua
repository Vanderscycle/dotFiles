-- Imports
-- =========================================
require("plugins.default")
require("lsp-config.lua")
require("lsp-config.bash")
-- require("lsp-config.rust")
require("lsp-config.typescript")
require("lsp-config.javascript")
require("lsp-config.python")
require("lsp-config.markdown")
require("lsp-config.tailwindcss")

--LSP
require("lsp-config.general")
-- keybindings
-- =========================================

-- Customization
-- =========================================
require("user.autocommands")
-- user specific
-- =========================================
require("user.keybindings")
require("user.todoComments")
require("user.general")
-- Linter/Formatters
-- =========================================
