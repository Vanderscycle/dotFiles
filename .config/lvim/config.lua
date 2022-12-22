-- WIP: learn surround,hlslens and lightspeed plugins
--
-- TODO: whenever I open an MD file a second split window should also open

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

-- post plugin config
-- =========================================
require("plugins.tokyonight").config() -- needs to be configured prior loading
require("colorizer").setup()
require("document-color").buf_attach()
-- require("lsp.tailwindcss") -- WARN: working?
-- require("hologram").setup({
-- 	auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
-- })

-- Customization
-- =========================================
require("user.autocommands")
require("user.keybindings").config()

-- user specific
-- =========================================
-- require("renamer").setup({})
require("telescope").load_extension("media_files")
require("plugins.telescope").config()
require("plugins.lualine").config() -- working?
require("user.autocommands").config()
require("luasnip/loaders/from_vscode").load({
	paths = { "~/.config/lvim/snippets" },
})
-- adding friendly snippets to
require("luasnip.loaders.from_snipmate").lazy_load()
vim.diagnostic.config({ virtual_lines = true })
require("user.general").config()
-- install lsps
require("mason-lspconfig").setup({
	ensure_installed = {
		"sumneko_lua",
		"rust_analyzer",
		"gopls",
		"bashls",
		"dockerls",
		"yamlls",
		"tsserver",
		"svelte",
		"hls",
		"pyright",
		"jsonls",
		"emmet_ls",
	},
})
require("lsp")
-- vim.g.gitblame_ignored_filetypes = { "NvimTree" }
-- vim.g.gitblame_highlight_group = "Todo"

-- =========================================
-- TODO: lightbulb/codelens auto action
--TODO: learn about luasnip
-- TODO: fix  the keybindings and assign leader t for telescope
-- unfuck section g (no leader)
-- figure out folds z
-- vim.api.nvim_create_autocmd

-- https://chrisarcand.com/vims-new-cdo-command/ cdo/cfdo for bqf batch renaming
-- TODO: coda actions requires telescope drop down menu
--TODO: add a telescopr config and plugins
--
--TODO: when opening an md open another side window running glow
--WARN: toggletern not woking and nvim-surround unaware
--WARN: use telescope/quick lists
--BUG: check on
