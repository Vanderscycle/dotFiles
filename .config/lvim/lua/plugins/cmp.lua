local lspkind = require("lspkind")

local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  cmp_tabnine = "[TN]",
  path = "[Path]",
}

local M = {}

M.config = function()
  local status_ok, cmp = pcall(require, "cmp")
  if not status_ok then
    return
  end

  cmp.setup({
    sources = {
      { name = "cmp_tabnine" },
    },
    formatting = {
      format = function(entry, vim_item)
        vim_item.kind = lspkind.presets.default[vim_item.kind]
        local menu = source_mapping[entry.source.name]
        if entry.source.name == "cmp_tabnine" then
          if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
            menu = entry.completion_item.data.detail .. " " .. menu
          end
          vim_item.kind = ""
        end
        vim_item.menu = menu
        return vim_item
      end,
    },
  })
end

return M