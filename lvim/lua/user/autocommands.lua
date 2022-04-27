local M = {}

M.config = function()
	lvim.autocommands.custom_groups = {
		-- On entering insert mode in any file, scroll the window so the cursor line is centered
		{ "InsertEnter", "*", ":normal zz" },
		-- {"","*", ":<Esc>" }
	}
	vim.cmd([[
  :autocmd BufWinEnter * setlocal modifiable
  ]])
end

return M
