local M = {}
M.config = function()
	local status_ok, tokyonight = pcall(require, "tokyonight")
	if not status_ok then
		return
	end

	tokyonight.setup({
		-- use the night style
		style = "night",
		-- disable italic for functions
		styles = {
			functions = "NONE",
		},
	})
end
return M
