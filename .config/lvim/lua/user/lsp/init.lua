local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end
-- navic
-- https://github.com/SmiteshP/Dotfiles/blob/master/.config/nvim/lua/config/lsp.lua

-- organization
-- https://github.com/ChristianChiarulli/nvim/tree/master/lua/user/lsp

-- Common Configuration
local common_config = {}
local function documentHighlight(client, bufnr)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    local lsp_document_highlight = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = lsp_document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
      group = lsp_document_highlight,
      buffer = 0,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = function()
        vim.lsp.buf.clear_references()
      end,
      group = lsp_document_highlight,
      buffer = 0,
    })
  end
end

function common_config.common_on_attach(client, bufnr)
  require("nvim-navic").attach(client, bufnr)
  require("lsp_signature").on_attach()
  documentHighlight(client, bufnr)
end

-- cmp-lsp capabilities
common_config.capabilities = vim.lsp.protocol.make_client_capabilities()
common_config.capabilities = require("cmp_nvim_lsp").update_capabilities(common_config.capabilities)
-- configure all of your lsp server here
lspconfig.sumneko_lua.setup({
  on_attach = common_config.common_on_attach,
  capabilities = common_config.capabilities,
  filetypes = { "lua" },
  rootPatterns = { ".git" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = { "vim", "Config" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
        maxPreload = 10000,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
-- lspconfig.tsserver.setup({
-- 	on_attach = common_config.common_on_attach,
-- 	capabilities = common_config.capabilities,
-- 	root_dir = lspconfig.util.root_pattern("package.json"),
-- 	init_options = {
-- 		lint = true,
-- 	},
-- })
