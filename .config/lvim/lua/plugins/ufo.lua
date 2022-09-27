local M = {}

M.config = function()
	local status_ok, ufo = pcall(require, "ufo")
	-- NOTE: have to ensure the plugin name is correct (not the file)
	if not status_ok then
		return
	end

	ufo.setup({

		provider_selector = function(bufnr, filetype, buftype)
			return { "treesitter", "indent" }
		end,
	})
	-- vim.o.foldcolumn = "1"
	vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true
end

return M
