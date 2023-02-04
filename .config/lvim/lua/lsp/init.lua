local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

if not configs.helm_ls then
	configs.helm_ls = {
		default_config = {
			cmd = { "helm_ls", "serve" },
			filetypes = { "helm" },
			root_dir = function(fname)
				return util.root_pattern("Chart.yaml")(fname)
			end,
		},
	}
end

lspconfig.helm_ls.setup({
	filetypes = { "helm" },
	cmd = { "helm_ls", "serve" },
})

-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
-- 	pattern = "*.yaml",
-- 	callback = function()
-- 		vim.opt_local.filetype = "helm"
-- 	end,
-- })
--
local function detach_yamlls()
	local clients = vim.lsp.get_active_clients()
	for client_id, client in pairs(clients) do
		if client.name == "yamlls" then
			vim.lsp.buf_detach_client(0, client_id)
		end
	end
end

local gotmpl_group = vim.api.nvim_create_augroup("_gotmpl", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = gotmpl_group,
	pattern = "yaml",
	callback = function()
		vim.schedule(function()
			local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
			for _, line in ipairs(lines) do
				if string.match(line, "{{.+}}") then
					vim.defer_fn(detach_yamlls, 500)
					return
				end
			end
		end)
	end,
})
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
	-- if s == "yamlls" then
	-- 	-- Wrapping the "default" function like this is important.
	-- 	-- if vim.bo.buftype ~= "" or vim.bo.filetype == "helm" then
	-- 	--   vim.diagnostic.disable()
	-- 	-- end
	-- 	if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
	-- 		vim.diagnostic.disable(bufnr)
	-- 		vim.defer_fn(function()
	-- 			vim.diagnostic.reset(nil, bufnr)
	-- 		end, 1000)
	-- 	end
	-- elseif vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "env" then
	-- 	vim.diagnostic.disable(bufnr)
	-- 	vim.defer_fn(function()
	-- 		vim.diagnostic.reset(nil, bufnr)
	-- 	end, 1000)
	-- -- elseif vim.bo.filename == "*.env" then
	-- 	vim.diagnostic.disable()
	-- end
	-- else
	lspconfig[s].setup({
		on_attach = on_attach,
	})
end
-- end

-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(name)
-- 	return name ~= "tailwindcss"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- lspconfig["tailwindcss"].setup({
-- 	require("document-color").buf_attach(bufnr, { mode = "background" }),
-- 	-- on_attach = on_attach,
-- })
