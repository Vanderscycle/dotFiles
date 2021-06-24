-- colors

local bar_fg = "#565c64"
local activeBuffer_fg = "#c8ccd4"

require "bufferline".setup {
      options = {
        offsets = {{filetype = "NvimTree", text = "", padding = 1}},
        buffer_close_icon = "",
        modified_icon = "",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
        show_tab_indicators = true,
        enforce_regular_tabs = false,
        view = "multiwindow",
        show_buffer_close_icons = true,
        separator_style = "thin",
        mappings = "true"
    },
    --TODO: move all the scheme to highlights
    highlights = {
        background = {
            guifg = bar_fg,
            guibg = "#1e222a"
        },
        fill = {
            guifg = bar_fg,
            guibg = "#1e222a"
        },
        -- focused window
        buffer_selected = {
            guifg = activeBuffer_fg,
            guibg = "#353b45",
            gui = "bold"
        },
        --y
        separator_selected = {
            guifg = "#353b45",
            guibg = "#353b45"
        },
        -- unfocused opened window
        buffer_visible = {
            guifg = "#9298a0",
            guibg = "#282c34"
        },
        separator_visible = {
            guifg = "#282c34",
            guibg = "#282c34"
        },
        separator = {
            guifg = "#1e222a",
            guibg = "#1e222a"
        },
        indicator_selected = {
            guifg = "#1e222a",
            guibg = "#1e222a"
        },
        -- y
        modified_selected = {
            guifg = "#d0f5c2",
            guibg = "#353b45"
        }
    }
}

local opt = {silent = true}

local map = vim.api.nvim_set_keymap
vim.g.mapleader = " "

--command that adds new buffer and moves to it
map("n", "<S-t>", [[<Cmd>tabnew<CR>]], opt)

--removing a buffer
map("n", "<S-x>", [[<Cmd>bdelete<CR>]], opt)

-- tabnew and tabprev
map("n", "<TAB>", [[<Cmd>BufferLineCycleNext<CR>]], opt)
map("n", "<S-TAB>", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
