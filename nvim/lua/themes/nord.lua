-- reference only (not sure why they don't highlight)
-- https://www.nordtheme.com/docs/colors-and-palettes

local nordColors = {
    base00 = "2E3440",
    base01 = "3B4252",
    base02 = "434C5E",
    base03 = "4C566A",
    base04 = "D8DEE9",
    base05 = "E5E9F0",
    base06 = "ECEFF4",
    base07 = "8FBCBB",
    base08 = "88C0D0",
    base09 = "81A1C1",
    base0A = "5E81AC",
    base0B = "BF616A",
    base0C = "D08770",
    base0D = "EBCB8B",
    base0E = "A3BE8C",
    base0F = "B48EAD"
}
-- Honestly you did such a good job with the blacks/greys that touching them makes it look worse
-- most of the changes has to be done at the ui level e.g. statusline set to blue vice red/green and highlight changes
local colors = {
    white = "#abb2bf",
    darker_black = "#1b1f27",
    black = "#1e222a", --  nvim bg
    black2 = "#252931",
    one_bg = "#282c34", -- real bg of onedark
    one_bg2 = "#353b45",
    one_bg3 = "#30343c",
    grey = "#42464e",
    grey_fg = "#565c64",
    grey_fg2 = "#6f737b",
    light_grey = "#6f737b",
    red = "#BF616A",
    baby_pink = "#BF616A",
    pink = "#ff75a0", --nord doesn't really have pink
    line = "#2a2e36", -- for lines like vertsplit
    green = "#A3BE8C",
    vibrant_green = "#A3BE8C",
    nord_blue = "#81A1C1",
    blue = "#5E81AC",
    yellow = "#EBCB8B",
    sun = "#EBCB8B",
    purple = "#B48EAD",
    dark_purple = "#B48EAD",
    teal = "#8FBCBB",
    orange = "#D08770",
    cyan = "#88C0D0",
    statusline_bg = "#22262e",
    lightbg = "#2d3139",
    lightbg2 = "#262a32"
}

return colors

