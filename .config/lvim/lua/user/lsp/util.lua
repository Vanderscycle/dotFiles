local M = {}

M.documentHighlight = function(client, bufnr)
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		local lsp_document_highlight = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = lsp_document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = function()
				vim.lsp.buf.document_highlight()
			end,
			group = lsp_document_highlight,
			buffer = 0,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			callback = function()
				vim.lsp.buf.clear_references()
			end,
			group = lsp_document_highlight,
			buffer = 0,
		})
	end
end

M.common_on_attach = function(client, bufnr)
	require("nvim-navic").attach(client, bufnr)
	require("lsp_signature").on_attach()
	M.documentHighlight(client, bufnr)
end

M.root_pattern = function(...)
	local patterns = vim.tbl_flatten({ ... })
	local function matcher(path)
		for _, pattern in ipairs(patterns) do
			for _, p in ipairs(vim.fn.glob(M.path.join(path, pattern), true, true)) do
				if M.path.exists(p) then
					return path
				end
			end
		end
	end
end
return M
