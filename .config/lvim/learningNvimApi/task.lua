--TODO: figure out the relative improts
local function prequire(...)
	local status, lib = pcall(require, ...)
	if status then
		return lib
	end
	return nil
end

local pickers = prequire("telescope.pickers")
local finders = prequire("telescope.finders")
local sorters = prequire("telescope.sorters")
local previewers = require("telescope.previewers")
-- local input = { "tokyonight", "deus", "gruvbox" }
local input = { "task", "list" }
local opts = {
	-- INFO: if we have a table to sort through
	-- finder = finders.new_table(input),
	finder = finders.new_oneshot_job(input),
	sorter = sorters.get_generic_fuzzy_sorter(),
	prompt_title = title,
	previewer = previewers.new_termopen_previewer({
		get_command = function(entry)
			local tmp_table = vim.split(entry.value, "\t")
			-- vim.notify(tmp_table)
			if vim.tbl_isempty(tmp_table) then
				return { "echo", "" }
			end
			return { "echo", pickers.get_index() }
		end,
	}),
}
local title = "Current Tasks"

-- local picker = pickers.new(opts)
-- local res = picker:find()

local B = {}
B.task_list = function(opts)
	opts = opts or {}
	pickers.new(opts):find()
end
B.task_list(opts)
return B
-- WIP: https://github.com/nvim-telescope/telescope-github.nvim/blob/master/lua/telescope/_extensions/gh_builtin.lua
-- b for builtin function
-- B.gh_issues = function(opts)
-- 	opts = opts or {}
-- 	opts.limit = opts.limit or 100
-- 	local opts_query = parse_opts(opts, "issue")
-- 	local cmd = vim.tbl_flatten({ "gh", "issue", "list", opts_query })
-- 	local title = "Issues"
-- 	msgLoadingPopup("Loading " .. title, cmd, function(results)
-- 		if results[1] == "" then
-- 			print("Empty " .. title)
-- 			return
-- 		end
-- 		pickers.new(opts, {
-- 			prompt_title = title,
-- 			finder = finders.new_table({
-- 				results = results,
-- 				entry_maker = make_entry.gen_from_string(opts),
-- 			}),
-- 			previewer = previewers.new_termopen_previewer({
-- 				get_command = function(entry)
-- 					local tmp_table = vim.split(entry.value, "\t")
-- 					if vim.tbl_isempty(tmp_table) then
-- 						return { "echo", "" }
-- 					end
--INFO: how he gets the live view
-- 					return { "gh", "issue", "view", tmp_table[1] }
-- 				end,
-- 			}),
-- 			sorter = conf.file_sorter(opts),
-- 			attach_mappings = function(_, map)
-- 				actions.select_default:replace(gh_a.gh_issue_insert)
-- 				map("i", "<c-t>", gh_a.gh_web_view("issue"))
-- 				map("i", "<c-l>", gh_a.gh_issue_insert_markdown_link)
-- 				return true
-- 			end,
-- 		}):find()
-- 	end)
-- end
