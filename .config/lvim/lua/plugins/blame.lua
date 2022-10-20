local M = {}

M.config = function()
	local status_ok, blame = pcall(require, "blame")
	if not status_ok then
		return
	end

	vim.g.gitblame_ignored_filetypes = { "nvim-tree" }
	vim.g.gitblame_highlight_group = { "Question" }
	-- vim.g.gitblame_highlight_group = { "#ff9e64" }
	blame.setup({})
end

return M
