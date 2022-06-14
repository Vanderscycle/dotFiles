local M = {}

M.config = function()
	-- lightbulb/homemade codelens
	local codelens_viewer = "lua require('nvim-lightbulb').update_lightbulb()"
	local user = os.getenv("USER")
	if user and user == "henri" then
		codelens_viewer = "lua require('plugins.codelens').show_line_sign()"
	end
	-- vim.api.nvim_create_autocmd()
	lvim.autocommands.custom_groups = {
		-- On entering insert mode in any file, scroll the window so the cursor line is centered
		{ "InsertEnter", "*", ":normal zz" },
		-- { "CursorHold", "*", ":normal zz" },
		{ "CursorHold", "*.rs,*.go,*.ts,*.tsx", codelens_viewer },
		-- {"","*", ":<Esc>" }
	}
	vim.cmd([[
  :autocmd BufWinEnter * setlocal modifiable
  ]])
	vim.cmd([[
  augroup tune_colors | au!
    au ColorScheme * hi Cursor guibg=red guifg=white
  augroup END
]])
end

return M
