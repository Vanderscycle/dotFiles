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
            "typescript",
            "svelte"
            -- tailwindcss
            -- "rust",
            -- "go"
        },
        highlight = {
            enable = true,
            use_languagetree = true
        },
        context_commentstring = {
          enable = true
        }
}
end

return M
