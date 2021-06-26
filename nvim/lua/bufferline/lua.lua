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
        mappings = "true",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        custom_areas = {
            right = function()
                local result = {}
                local error = vim.lsp.diagnostic.get_count(0, [[Error]])
                local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
                local info = vim.lsp.diagnostic.get_count(0, [[Information]])
                local hint = vim.lsp.diagnostic.get_count(0, [[Hint]])

                if error ~= 0 then
                result[1] = {text = "  " .. error, guifg = "#EC5241"}
                end

                if warning ~= 0 then
                result[2] = {text = "  " .. warning, guifg = "#EFB839"}
                end

                if hint ~= 0 then
                result[3] = {text = "  " .. hint, guifg = "#A3BA5E"}
                end

                if info ~= 0 then
                result[4] = {text = "  " .. info, guifg = "#7EA9A7"}
            end
            return result
        end
    }

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
        modified_selected = {
            guifg = "#d0f5c2",
            guibg = "#353b45"
        }
    },

    }


