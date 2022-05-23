-- https://www.lunarvim.org/configuration/02-keybindings.html#whichkey-bindings
local M = {}
M.config = function()
	lvim.leader = "space"
	-- add your own keymapping
	lvim.keys.normal_mode["<leader>o"] = "o<Esc>"
	lvim.keys.normal_mode["<leader>O"] = "0<Esc>"
	lvim.keys.normal_mode["<S-x>"] = ":lua require('FTerm').toggle()<CR>"
	lvim.builtin.which_key.mappings["P"] = {
		name = "Plugin",
		r = { "<cmd>luafile %<cr>", "Reload Current File" },
	}
	-- lsp
	lvim.builtin.which_key.mappings["l"] = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
		w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
		f = { require("lvim.lsp.utils").format, "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = {
			vim.diagnostic.goto_next,
			"Next Diagnostic",
		},
		k = {
			vim.diagnostic.goto_prev,
			"Prev Diagnostic",
		},
		l = { vim.lsp.codelens.run, "CodeLens Action" },
		p = {
			name = "Peek",
			d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
			t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
			i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
		},
		q = { vim.diagnostic.setloclist, "Quickfix" },
		r = { vim.lsp.buf.rename, "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
		e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
	}
	-- search
	lvim.builtin.which_key.mappings["s"] = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		e = { ":lua require 'telescope'.extensions.file_browser.file_browser()<CR>", "Browser" },
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
	}
	lvim.builtin.which_key.mappings["b1"] = { "<Cmd>BufferLineGoToBuffer 1<CR>", "Buffer1" }
	lvim.builtin.which_key.mappings["b2"] = { "<Cmd>BufferLineGoToBuffer 2<CR>", "Buffer2" }
	lvim.builtin.which_key.mappings["b3"] = { "<Cmd>BufferLineGoToBuffer 3<CR>", "Buffer3" }
	lvim.builtin.which_key.mappings["b4"] = { "<Cmd>BufferLineGoToBuffer 4<CR>", "Buffer4" }
	lvim.builtin.which_key.mappings["b5"] = { "<Cmd>BufferLineGoToBuffer 5<CR>", "Buffer5" }
	lvim.builtin.which_key.mappings["b6"] = { "<Cmd>BufferLineGoToBuffer 6<CR>", "Buffer6" }
	lvim.builtin.which_key.mappings["b7"] = { "<Cmd>BufferLineGoToBuffer 7<CR>", "Buffer7" }
	lvim.builtin.which_key.mappings["b8"] = { "<Cmd>BufferLineGoToBuffer 8<CR>", "Buffer8" }
	lvim.builtin.which_key.mappings["b9"] = { "<Cmd>BufferLineGoToBuffer 9<CR>", "Buffer9" }

	lvim.builtin.which_key.mappings["E"] = {
		"<Cmd>SidebarNvimToggle<CR>",
		"Sidebar",
	}
	lvim.builtin.which_key.mappings["gg"] = {
		"<Cmd>LazyGit<CR>",
		"lazyGit",
	}
	lvim.builtin.which_key.mappings["Ln"] = {
		"<Cmd>NullLsInfo<CR>",
		"null-ls logs",
	}
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

M.set_glow_keymaps = function()
	vim.cmd([[ noremap <leader>G :Glow<CR> ]])
end

M.set_hlslens_keymaps = function()
	local opts = { noremap = true, silent = true }
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
