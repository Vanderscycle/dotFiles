local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end
local on_attach = function(client, bufnr)
	require("nvim-navic").attach(client, bufnr)
	require("lsp_signature").on_attach()
end

lspconfig["sumneko_lua"].setup({
	on_attach = on_attach,
})

lspconfig["gopls"].setup({
	on_attach = on_attach,
})

lspconfig["bashls"].setup({
	on_attach = on_attach,
})

lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(name)
	return name ~= "tailwindcss"
end, lvim.lsp.automatic_configuration.skipped_servers)

lspconfig["tailwindcss"].setup({
	require("document-color").buf_attach(bufnr, { mode = "background" }),
	-- on_attach = on_attach,
})
