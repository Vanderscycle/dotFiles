-- Imports
-- =========================================
require("plugins.default")
require("lsp-config.lua")
require("lsp-config.bash")
require("lsp-config.rust")
require("lsp-config.typescript")
require("lsp-config.javascript")
require("lsp-config.python")
require("lsp-config.markdown")

--LSP
require("lsp-config.general")
require("lsp-config.tailwindcss")
-- keybindings
-- =========================================
require("user.keybindings")

-- Customization
-- =========================================
require("user.autocommands")
-- general

-- lvim.autosave = true
lvim.format_on_save = true
lvim.lint_on_save = true

lvim.colorscheme = "tokyonight"
vim.opt.relativenumber = true
vim.opt.wrap = true
--lvim.log.level = "debug"
--TODO: move the keys to which_key plugin

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile

lvim.builtin.notify.active = true
lvim.builtin.notify.opts.background_colour = "normal"
lvim.builtin.cmp.completion.keyword_length = 2
lvim.lsp.automatic_servers_installation = true
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.autopairs.active = true
lvim.builtin.terminal.active = true
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"python",
	"lua",
	"bash",
	"dockerfile",
	"html",
	"javascript",
	"json",
	"svelte",
	"typescript",
	"yaml",
	"fish",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- Language Specific
-- =========================================
vim.list_extend(lvim.lsp.override, {
	"rust_analyzer",
})

require("user.todoComments")
