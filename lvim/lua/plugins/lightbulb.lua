local M = {}

M.config = function()
	local status_ok, lightbulb = pcall(require, "lightbulb")
	if not status_ok then
		return
	end

	lightbulb.setup({
		vim.fn.sign_define(
			"LightBulbSign",
			{ text = require("user.lsp_kind").icons.code_action, texthl = "DiagnosticInfo" }
		),
	})
end

return M
