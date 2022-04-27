-- TODO:
-- WIP: learn surround,hlslens and lightspeed plugins

-- enabling plugins
-- =========================================
lvim.builtin.motion_provider = "lightspeed"
lvim.builtin.sidebar = { active = true } -- enable/disable sidebar
lvim.builtin.hlslens = { active = true } -- enable/disable hlslens
lvim.builtin.tabnine = { active = true }
lvim.builtin.lightspeed = { active = true }

vim.list_extend(lvim.lsp.override, {
  "gopls"
})
-- vim.g.glow_binary_path = vim.env.HOME .. "/bin"
-- Extra plugin
-- =========================================
require("user.additionalPlugins").config()

-- Customization
-- =========================================
require("user.autocommands")
require("user.keybindings").config()

-- user specific
-- =========================================
-- require("user.todoComments ")
require("user.general").config()
require("user.autocommands").config()

-- Linter/Formatters
-- =========================================
require("linter_formatter.typescript").config()
require("linter_formatter.go").config()
require("linter_formatter.python").config()
-- require("linter_formatter.tailwindcss").config()
-- require("linter_formatter.bash").config()

-- require('user.null_ls').config()


--TODO:
-- Another pass at plugins that I use
-- A refinement of the plugins keybindings

