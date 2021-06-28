local M = {}

M.config = function()
    local ts_config = require("nvim-treesitter.configs")

    ts_config.setup {
        ensure_installed = {
            "javascript",
            "html",
            "css",
            "bash",
            "lua",
            "json",
            "python",
            "vue",
            "typescript"
            -- tailwindcss
            -- "rust",
            -- "go"
        },
        highlight = {
            enable = true,
            use_languagetree = true
        }
    }
end

return M
