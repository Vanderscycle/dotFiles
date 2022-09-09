local M = {}
M.config = function()
	local status_ok, lualine = pcall(require, "lualine")
	if not status_ok then
		return
	end

	lualine.setup({
		active = true,
		style = "lvim",
		theme = "tokyonight",
		options = {
			icons_enabled = nil,
			component_separators = nil,
			section_separators = nil,
			theme = nil,
			disabled_filetypes = nil,
			globalstatus = false,
		},
		sections = {
			lualine_a = nil,
			lualine_b = nil,
			lualine_c = nil,
			lualine_x = nil,
			lualine_y = nil,
			lualine_z = nil,
		},
		inactive_sections = {
			lualine_a = nil,
			lualine_b = nil,
			lualine_c = nil,
			lualine_x = nil,
			lualine_y = nil,
			lualine_z = nil,
		},
		tabline = nil,
		extensions = nil,
		on_config_done = nil,
	})
end
return M
