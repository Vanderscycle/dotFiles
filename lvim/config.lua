-- TODO:
-- WIP: learn surround,hlslens and lightspeed plugins

-- enabling plugins
-- =========================================
lvim.builtin.motion_provider = "lightspeed"
lvim.builtin.sidebar = { active = true } -- enable/disable sidebar
lvim.builtin.hlslens = { active = true } -- enable/disable hlslens
lvim.builtin.tabnine = { active = true }


-- Extra plugin
-- =========================================
require("user.additionalPlugins").config()

-- LSP
-- =========================================
-- require("lsp-config.general").config()

-- Customization
-- =========================================
-- require("user.autocommands")
require("user.keybindings").config()

-- user specific
-- =========================================
-- require("user.todoComments")
require("user.general").config()

-- Linter/Formatters
-- =========================================
-- require("lsp-config.lua")
-- require("lsp-config.bash")
-- require("lsp-config.rust")
-- require("lsp-config.svelte").config()
require("lsp-config.typescript").config()
require("lsp-config.go").config()
-- require("lsp-config.javascript")
-- require("lsp-config.python")
-- require("lsp-config.markdown")
-- require("lsp-config.tailwindcss")

--TODO:
-- Another pass at plugins that I use
-- A refinement of the plugins keybindings

