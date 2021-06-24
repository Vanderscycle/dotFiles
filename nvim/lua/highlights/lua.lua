local cmd = vim.cmd

local colors = require "themes/onedark"

local white = colors.white
local darker_black = colors.darker_black
local black = colors.black
local black2 = colors.black2
local one_bg = colors.one_bg
local one_bg2 = colors.one_bg2
local one_bg3 = colors.one_bg3
local light_grey = colors.light_grey
local grey = colors.grey
local grey_fg = colors.grey_fg
local red = colors.red
local line = colors.line
local green = colors.green
local nord_blue = colors.nord_blue
local blue = colors.blue
local yellow = colors.yellow
local purple = colors.purple
-- for guifg , bg

local function fg(group, color)
    cmd("hi " .. group .. " guifg=" .. color)
end

local function bg(group, color)
    cmd("hi " .. group .. " guibg=" .. color)
end

local function fg_bg(group, fgcol, bgcol)
    cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

-- blankline

fg("IndentBlanklineChar", line)

-- misc --
fg("LineNr", "#42464e")
fg("Comment", "#42464e")
fg("NvimInternalError", "#bf616a")
fg("VertSplit", "#2a2e36")
fg("EndOfBuffer", "#1e222a")

-- Pmenu
bg("Pmenu", "#282c34")
bg("PmenuSbar", "#434c5e")
bg("PmenuSel", "#a3be8c")
bg("PmenuThumb", "#81a1c1")

-- inactive statuslines as thin splitlines
cmd("hi! StatusLineNC gui=underline guifg=" .. line)

-- line n.o
cmd "hi clear CursorLine"
fg("cursorlinenr", "#42464e")

-- git signs ---
fg_bg("DiffAdd", "#81a1c1", "none")
fg_bg("DiffChange", "#3A3E44", "none")
fg_bg("DiffModified", "#81a1c1", "none")

-- NvimTree
fg("NvimTreeFolderIcon", '#88C0D0')
fg("NvimTreeFolderName", '#88C0D0')
fg("NvimTreeIndentMarker", "#D8DEE9")
fg("NvimTreeVertSplit", "#2e3440")
bg("NvimTreeVertSplit", "#2e3440")

fg("NvimTreeRootFolder", "#2e3440")
bg("NvimTreeNormal", "#2e3440")
fg_bg("NvimTreeStatuslineNc", "#2e3440","#2e3440")

-- telescope
fg("TelescopeBorder", "#2a2e36")
fg("TelescopePromptBorder", "#2a2e36")
fg("TelescopeResultsBorder", "#2a2e36")
fg("TelescopePreviewBorder", :"#525865")

-- LspDiagnostics ---

-- error / warnings
fg("LspDiagnosticsSignError", "#bf616a")
fg("LspDiagnosticsVirtualTextError", "#bf616a")
fg("LspDiagnosticsSignWarning", "#ebcb8b")
fg("LspDiagnosticsVirtualTextWarning", "#ebcb8b")

-- info
fg("LspDiagnosticsSignInformation", "#a3be8c")
fg("LspDiagnosticsVirtualTextInformation", "#a3be8c")

-- hint
fg("LspDiagnosticsSignHint", "#b48ead")
fg("LspDiagnosticsVirtualTextHint", "#b48ead")

-- bufferline

fg_bg("BufferLineFill", grey_fg, black2)
fg_bg("BufferLineBackground", light_grey, black2)

fg_bg("BufferLineBufferVisible", light_grey, black2)
fg_bg("BufferLineBufferSelected", white, black)

cmd "hi BufferLineBufferSelected gui=bold"

-- tabs
fg_bg("BufferLineTab", light_grey, one_bg3)
fg_bg("BufferLineTabSelected", black2, nord_blue)
fg_bg("BufferLineTabClose", red, black)

fg_bg("BufferLineIndicator", black2, black2)
fg_bg("BufferLineIndicatorSelected", black, black)

-- separators
fg_bg("BufferLineSeparator", line, "#353b45")
fg_bg("BufferLineSeparatorVisible", line, "#353b45")
fg_bg("BufferLineSeparatorSelected", "#353b45","#353b45")

-- modified buffers
fg_bg("BufferLineModified", red, black2)
fg_bg("BufferLineModifiedVisible", red, black2)
fg_bg("BufferLineModifiedSelected", '#d0f5c2', "#353b45")

-- close buttons
fg_bg("BufferLineCLoseButtonVisible", light_grey, black2)
fg_bg("BufferLineCLoseButton", light_grey, black2)
fg_bg("BufferLineCLoseButtonSelected", red, black)

-- dashboard

fg("DashboardHeader", grey_fg)
fg("DashboardCenter", grey_fg)
fg("DashboardShortcut", grey_fg)
fg("DashboardFooter", grey_fg)

-- Default nvim bg
-- cmd "hi Normal guibg=#1e222a"
