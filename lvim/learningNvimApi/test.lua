-- add all elements of array `a'
local squares = { 1, 4, 9, 16, 25, 36, 49, 64, 81 }
local function add(a)
	local sum = 0
	for _, v in ipairs(a) do
		sum = sum + v
	end
	return sum
end

local function prequire(...)
	local status, lib = pcall(require, ...)
	if status then
		return lib
	end
	return nil
end

local M = {}

M.hello_Vnim = function()
	local basicSteps = add(squares)
	vim.notify("hello Worl d" .. basicSteps)
end
M.openTelescope = function()
	-- just sinmple function that call telescope
	local telescope = prequire("telescope")
	if not telescope then
		return
	end
	vim.api.nvim_set_keymap("n", "<leader>K", ":Telescope<CR>", {})
end
M.hello_Vnim()
M.openTelescope()
-- learn about calling this file and then subsequent function.
-- learn lua and make open the result of notify in a floating buffer.
return M
