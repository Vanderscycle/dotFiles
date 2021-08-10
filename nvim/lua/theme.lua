g = vim.g
g.nvchad_theme = "chadracula"

local present, base16 = pcall(require, "base16")

if present then
    base16(base16.themes("chadracula"), true)
    require "highlights"
    return true
else
    return false
end
