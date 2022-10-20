local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local on_attach = function(client, bufnr)
	-- require("nvim-navic").attach(client, bufnr)
	require("lsp_signature").on_attach(client, bufnr)
end

local desired_servers = { "sumneko_lua", "tsserver", "emmet", "svelte", "gopls", "pyright", "bashls", "yamlls" }
-- for _, s in pairs(desired_servers) do
-- 	lspconfig[s].setup({
-- 		on_attach = on_attach,
-- 	})
-- end

for _, s in pairs(desired_servers) do
	if s == "yamlls" then
		-- Wrapping the "default" function like this is important.
		if vim.bo.buftype ~= "" or vim.bo.filetype == "helm" then
			vim.diagnostic.disable()
		end
	else
		lspconfig[s].setup({
			on_attach = on_attach,
		})
	end
end

-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(name)
-- 	return name ~= "tailwindcss"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- lspconfig["tailwindcss"].setup({
-- 	require("document-color").buf_attach(bufnr, { mode = "background" }),
-- 	-- on_attach = on_attach,
-- })
