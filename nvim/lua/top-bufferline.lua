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
    }
}
