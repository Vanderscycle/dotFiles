-- TODO:
-- WIP: learn surround,hlslens and lightspeed plugins

-- enabling plugins
-- =========================================
lvim.builtin.motion_provider = "lightspeed"
lvim.builtin.sidebar = { active = true } -- enable/disable sidebar
lvim.builtin.hlslens = { active = true } -- enable/disable hlslens
lvim.builtin.tabnine = { active = true }
lvim.builtin.lightspeed = { active = true }
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers({
-- 	"gopls",
-- }))

-- vim.g.glow_binary_path = vim.env.HOME .. "/bin"
-- Extra plugin
-- =========================================
require("user.additionalPlugins").config()
-- require("user.luasnip").config()
-- Customization
-- =========================================
require("user.autocommands")
require("user.keybindings").config()

-- user specific
-- =========================================
-- require("user.todoComments ")
require("user.general").config()
require("user.autocommands").config()
require("luasnip/loaders/from_vscode").load({
	paths = { "~/.config/lvim/snippets" },
})

-- WIP:
-- =========================================
-- TODO: lightbulb/codelens auto action
-- TODO: fix  the keybindings and assign leader t for telescope
-- unfuck section g (no leader)
-- figure out folds z
