local wilder = require("wilder")
wilder.set_option("use_python_remote_plugin", 0)
wilder.setup({ modes = { "/", "?", ":" } })

wilder.set_option("pipeline", {
	wilder.branch(
		wilder.python_file_finder_pipeline({
			file_comand = { "find", ".", "-type", "f", "-printf", "%P\n" },
			dir_comand = { "find", ".", "-type", "d", "-printf", "%P\n" },
			filters = { "fuzzy_filter", "difflib_sorter" },
		}),
		wilder.cmdline_pipeline(),
		wilder.python_search_pipeline()
	),
})
