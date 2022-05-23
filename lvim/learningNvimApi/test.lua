-- https://www.google.com/search?client=firefox-b-d&q=nvim+workbench -- example plugin
-- https://github.com/jacobsimpson/nvim-example-lua-plugin
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

Width = 50
Height = 10
Value = ""
local H = {}
-- https://neovim.io/doc/user/api.html#nvim_open_win()
H.window_config = function(width, height)
	return {
		relative = "editor",
		width = width,
		height = height,
		col = (ui.width - width) / 2,
		row = (ui.height - height) / 2,
		style = "minimal",
		focusable = false,
		border = "double",
	}
end
H.floatingWindow = function()
	-- This will call a unix command
	local file = io.popen("echo test")
	-- This will read all of the output, as always
	local output = file:read("*all")
	-- This will get a table with some return stuff
	-- rc[1] will be true, false or nil
	-- rc[3] will be the signal
	local rc = { file:close() }
	-- return status
	local t = os.execute("echo 'test'") -- outputs the code res
	local s = string.gsub(output, "n", "")
	-- vim.notify(s)

	-- using plenary
	-- https://github.com/nvim-lua/plenary.nvim#plenaryjob
	local Job = prequire("plenary.job")
	Job
		:new({
			command = "echo",
			args = { "test" },
			on_stdout = function(j, return_val)
				-- vim.notify(return_val)
				Value = return_val
			end,
			on_exit = function(j, return_val)
				print(return_val)
				print(j:result())
			end,
		})
		:sync()
	-- displaying in a buffer
	--Get the current UI
	ui = vim.api.nvim_list_uis()[1]
	local buf = vim.api.nvim_create_buf(false, true)
	local win_id = vim.api.nvim_open_win(buf, true, H.window_config(Width, Height))
	-- https://neovim.io/doc/user/api.html#nvim_buf_set_lines()
	-- vim.api.nvim_buf_set_name(buf, "title")
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { " hello world " .. t .. Value })
end

local M = {}

M.hello_Vnim = function()
	local basicSteps = add(squares)
	vim.notify("hello World " .. "sum of squares " .. basicSteps)
	H.floatingWindow()
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
