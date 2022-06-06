local M = {}
M.config = function()
	local status_ok, inc_rename = pcall(require, "inc_rename")
	if not status_ok then
		return
	end
	inc_rename.setup({
		cmd_name = "IncRename", -- the name of the command
		hl_group = "Substitute", -- the highlight group used for highlighting the new identifier's name
	})
end

return M
