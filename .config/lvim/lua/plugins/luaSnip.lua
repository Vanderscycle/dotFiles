local function prequire(...)
	local status, lib = pcall(require, ...)
	if status then
		return lib
	end
	return nil
end

local M = {}

M.config = function()
	local luasnip = prequire("luasnip")
	local cmp = prequire("cmp")
	luasnip.setup({
		show_numbers = true, -- Enable 'number' for the window while peeking
		show_cursorline = true, -- Enable 'cursorline' for the window while peeking
		number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
		centered_peeking = true, -- Peeked line will be centered relative to window
	})

	local t = function(str)
		return vim.api.nvim_replace_termcodes(str, true, true, true)
	end

	local check_back_space = function()
		local col = vim.fn.col(".") - 1
		if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
			return true
		else
			return false
		end
	end

	_G.tab_complete = function()
		if cmp and cmp.visible() then
			cmp.select_next_item()
		elseif luasnip and luasnip.expand_or_jumpable() then
			return t("<Plug>luasnip-expand-or-jump")
		elseif check_back_space() then
			return t("<Tab>")
		else
			cmp.complete()
		end
		return ""
	end

	_G.s_tab_complete = function()
		if cmp and cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip and luasnip.jumpable(-1) then
			return t("<Plug>luasnip-jump-prev")
		else
			return t("<S-Tab>")
		end
		return ""
	end
	require("user.keybindings").set_luasnip_keymaps()
end

return M
