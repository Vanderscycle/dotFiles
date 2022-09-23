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
end

return M
