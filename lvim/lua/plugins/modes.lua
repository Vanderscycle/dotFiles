local M = {}

M.config = function()
	local status_ok, modes = pcall(require, "modes")
	if not status_ok then
		return
	end

	modes.setup({
		colors = {
			copy = "#e0af68", --yellow
			delete = "#f7768e", --red
			insert = "#73daca",
			visual = "#bb9af7", --purple
		},

		-- Set opacity for cursorline and number background
		line_opacity = 0.15,

		-- Enable cursor highlights
		set_cursor = true,

		-- Enable cursorline initially, and disable cursorline for inactive windows
		-- or ignored filetypes
		set_cursorline = true,

		-- Enable line number highlights to match cursorline
		set_number = true,

		-- Disable modes highlights in specified filetypes
		-- Please PR commonly ignored filetypes
		ignore_filetypes = { "NvimTree", "TelescopePrompt" },
	})
end

return M
