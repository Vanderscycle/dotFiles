local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
    return
end

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
        "svelte",
        -- "tailwindcss"
    },
    highlight = {
        enable = true,
        use_languagetree = true
    }
}
