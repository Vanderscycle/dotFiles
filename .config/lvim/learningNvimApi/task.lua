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

-- local input = { "tokyonight", "deus", "gruvbox" }
local input = { "task", "list" }
local opts = {
	-- INFO: if we have a table to sort through
	-- finder = finders.new_table(input),
	finder = finders.new_oneshot_job(input),
	sorter = sorters.get_generic_fuzzy_sorter(),
}

local picker = pickers.new(opts)
picker:find()
