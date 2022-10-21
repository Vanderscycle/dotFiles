-- https://www.lunarvim.org/configuration/02-keybindings.html#whichkey-bindings
local M = {}
M.config = function()
	lvim.leader = "space"
	-- tabs
	lvim.builtin.which_key.mappings["t"] = {
		name = "Tabs",
		n = { "<cmd>:tabnew<cr>", "New Tab" },
		j = { "<cmd>:tabprevious<cr>", "Previous Tab" },
		k = { "<cmd>:tabnext<cr>", "Next Tab" },
		q = { "<cmd>:tabclose<cr>", "Close Tab" },
	}
	-- zettelkasten
	lvim.builtin.which_key.mappings["z"] = {
		name = "zettelkasten",
		f = { ":lua require('telekasten').find_notes()<cr>", "Find Notes" },
		n = { ":lua require('telekasten').new_note()<cr>", "New Notes" },
		i = { ":lua require('telekasten').insert_link()<cr>", "Insert Link" },
		d = { ":lua require('telekasten').find_daily_notes()<cr>", "Find Daily Notes" },
		g = { ":lua require('telekasten').search_notes()<cr>", "Search Notes" },
		l = { ":lua require('telekasten').follow_link()<cr>", "Follow Link" },
		p = { ":lua require('telekasten').panel()<cr>", "Open Panel" },
		a = {
			l = { ":CalendarVR<cr>", "Open Calendar R" },
			L = { ":Calendar<cr>", "Open Calendar L" },
		},
	}
	-- git

	lvim.builtin.which_key.mappings["g"] = {
		name = "Git",
		f = { ":DiffviewFileHistory % <cr>", "History" },
		j = { ":lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { ":lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { ":lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { ":lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { ":lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { ":lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { ":lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		C = {
			"<cmd>Telescope git_bcommits<cr>",
			"Checkout commit(for current file)",
		},
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Git Diff",
		},
	}
	-- git

	lvim.builtin.which_key.mappings["m"] = {
		name = "CodeWindow",
		m = { ":codewindow.open_minimap() <cr>", "open" },
		c = { ":codewindow.close_minimap() <cr>", "close" },
		f = { ":codewindow.toggle_focus() <cr>", "focus" },
	}

	-- lsp
	-- lvim.builtin.which_key.mappings["l"] = {
	-- 	name = "LSP",
	-- 	a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
	-- 	d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
	-- 	w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
	-- 	f = { require("lvim.lsp.utils").format, "Format" },
	-- 	i = { "<cmd>LspInfo<cr>", "Info" },
	-- 	I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
	-- 	j = {
	-- 		vim.diagnostic.goto_next,
	-- 		"Next Diagnostic",
	-- 	},
	-- 	k = {
	-- 		vim.diagnostic.goto_prev,
	-- 		"Prev Diagnostic",
	-- 	},
	-- 	l = { vim.lsp.codelens.run, "CodeLens Action" },
	-- 	p = {
	-- 		name = "Peek",
	-- 		d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
	-- 		t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
	-- 		i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
	-- 	},
	-- 	q = { vim.diagnostic.setloclist, "Quickfix" },
	-- 	-- r = { vim.lsp.buf.rename, "Rename" },
	-- 	r = {
	-- 		'<cmd>lua require("renamer").rename()<cr>',
	-- 		"Rename",
	-- 	},
	-- 	s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
	-- 	S = {
	-- 		"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
	-- 		"Workspace Symbols",
	-- 	},
	-- 	e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
	-- }

	-- search
	lvim.builtin.which_key.mappings["s"] = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		e = { ":lua require 'telescope'.extensions.file_browser.file_browser()<CR>", "Browser" },
		m = { ":lua require'telescope.builtin'.symbols{ sources = {'emoji', 'kaomoji', 'gitmoji'} }<CR>", "emoji" },
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		t = { "<cmd>Telescope live_grep<cr>", "Text" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
		p = {
			"<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
			"Colorscheme with Preview",
		},
		T = { ":Telescope current_buffer_fuzzy_find bufnr=0 theme=get_ivy<cr>", "Current Buffer Word Find" },
		F = {
			':lua require("telescope.builtin").find_files({hidden=true, no_ignore=true, find_command=rg})<cr>',
			"Find File *Ignore",
		},
	}

	-- buffer
	lvim.builtin.which_key.mappings["b"] = {
		name = "buffer",
		j = { "<cmd>BufferLinePick<cr>", "Jump" },
		f = { "<cmd>Telescope buffers<cr>", "Find" },
		b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
		-- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
		K = { "<cmd>%bd | e#<CR>", "Close all but current" },
		e = {
			"<cmd>BufferLinePickClose<cr>",
			"Pick which buffer to close",
		},
		h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
		l = {
			"<cmd>BufferLineCloseRight<cr>",
			"Close all to the right",
		},
		D = {
			"<cmd>BufferLineSortByDirectory<cr>",
			"Sort by directory",
		},
		L = {
			"<cmd>BufferLineSortByExtension<cr>",
			"Sort by language",
		},
		t = {
			name = "+Term",
			b = { "<cmd>ToggleTerm size=20 direction=horizontal<cr>", "Bottom Term" },
			f = { "<cmd>ToggleTerm<cr>", "Floating Term" },
		},
	}
	-- lvim doesn't support numbers
	lvim.builtin.which_key.mappings["b1"] = { "<Cmd>BufferLineGoToBuffer 1<CR>", "Buffer1" }
	lvim.builtin.which_key.mappings["b2"] = { "<Cmd>BufferLineGoToBuffer 2<CR>", "Buffer2" }
	lvim.builtin.which_key.mappings["b3"] = { "<Cmd>BufferLineGoToBuffer 3<CR>", "Buffer3" }
	lvim.builtin.which_key.mappings["b4"] = { "<Cmd>BufferLineGoToBuffer 4<CR>", "Buffer4" }
	lvim.builtin.which_key.mappings["b5"] = { "<Cmd>BufferLineGoToBuffer 5<CR>", "Buffer5" }
	lvim.builtin.which_key.mappings["b6"] = { "<Cmd>BufferLineGoToBuffer 6<CR>", "Buffer6" }
	lvim.builtin.which_key.mappings["b7"] = { "<Cmd>BufferLineGoToBuffer 7<CR>", "Buffer7" }
	lvim.builtin.which_key.mappings["b8"] = { "<Cmd>BufferLineGoToBuffer 8<CR>", "Buffer8" }
	lvim.builtin.which_key.mappings["b9"] = { "<Cmd>BufferLineGoToBuffer 9<CR>", "Buffer9" }
	-- individual
	lvim.builtin.which_key.mappings["P"] = {
		name = "Plugin",
		r = { "<cmd>luafile %<cr>", "Reload Current File" },
	}
	lvim.builtin.which_key.mappings["E"] = {
		"<Cmd>SidebarNvimToggle<CR>",
		"Sidebar",
	}
	lvim.builtin.which_key.mappings["w"] = {
		"<Cmd>wa<CR>",
		"save all",
	}
	lvim.builtin.which_key.mappings["gg"] = {
		"<Cmd>LazyGit<CR>",
		"lazyGit",
	}
	-- config specific
	lvim.builtin.which_key.mappings["LK"] = {
		"<cmd>edit " .. get_config_dir() .. "/lua/user/keybindings.lua<cr>",
		"Edit Keybindings",
	}
	lvim.builtin.which_key.mappings["LP"] = {
		"<cmd>edit " .. get_config_dir() .. "/lua/user/additionalPlugins.lua<cr>",
		"Edit Keybindings",
	}
	lvim.builtin.which_key.mappings["lr"] = {
		'<cmd>lua require("renamer").rename()<cr>',
		"Rename",
	}
	-- better inserts
	lvim.builtin.which_key.mappings["o"] = {
		"o<Esc>",
		"insert ln blw",
	}
	lvim.builtin.which_key.mappings["O"] = {
		"O<Esc>",
		"insert ln abv",
	}

	-- https://github.com/rmagatti/goto-preview
	M.set_goto_preview_keybindings = function()
		-- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
		-- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
		-- vim.cmd("nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>")
		-- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
	end

	M.set_luasnip_keymaps = function()
		vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
		vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
		vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
		vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
		vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
		vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})
	end

	-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
	local actions = require("telescope.actions")
	lvim.builtin.telescope.defaults.mappings = {
		i = {
			["<C-j>"] = actions.move_selection_next,
			["<C-k>"] = actions.move_selection_previous,
			["<C-n>"] = actions.cycle_history_next,
			["<C-p>"] = actions.cycle_history_prev,
		},
		n = {
			["<C-j>"] = actions.move_selection_next,
			["<C-k>"] = actions.move_selection_previous,
		},
	}
end

M.set_hlslens_keymaps = function()
	local opts = { noremap = true, silent = true }
	vim.keymap.set({ "n", "x" }, "z*", function()
		vim.api.nvim_feedkeys(
			vim.api.nvim_replace_termcodes([[<Plug>(asterisk-gz*)<Cmd>noh<CR>]], true, false, true),
			"in",
			false
		)
		vim.schedule(function()
			if require("hlslens").exportLastSearchToQuickfix() then
				vim.cmd("cw")
			end
		end)
	end)
	vim.api.nvim_set_keymap(
		"n",
		"n",
		"<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>",
		opts
	)
	vim.api.nvim_set_keymap(
		"n",
		"N",
		"<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>",
		opts
	)
	vim.api.nvim_set_keymap("n", "*", "*<Cmd>lua require('hlslens').start()<CR>", opts)
	vim.api.nvim_set_keymap("n", "#", "#<Cmd>lua require('hlslens').start()<CR>", opts)
	vim.api.nvim_set_keymap("n", "g*", "g*<Cmd>lua require('hlslens').start()<CR>", opts)
	vim.api.nvim_set_keymap("n", "g#", "g#<Cmd>lua require('hlslens').start()<CR>", opts)
end

M.set_lightspeed_keymaps = function()
	vim.cmd([[
nmap s <Plug>Lightspeed_s
nmap S <Plug>Lightspeed_S
nmap <expr> f reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_f" : "f"
nmap <expr> F reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_F" : "F"
nmap <expr> t reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_t" : "t"
nmap <expr> T reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_T" : "T"
  ]])
end

return M
