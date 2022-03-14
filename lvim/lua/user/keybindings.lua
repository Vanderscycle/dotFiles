local M = {}
M.config = function ()
  lvim.leader = "space"
  -- add your own keymapping
  lvim.keys.normal_mode["<leader>o"] = "o<Esc>" -- BUG: FIX THESE 2 BINDINGS
  lvim.keys.normal_mode["<leader>O"] = "0<Esc>"
  lvim.keys.normal_mode["<S-x>"] = ":lua require('FTerm').toggle()<CR>"


  lvim.keys.normal_mode = {
    -- empowered searches
    ["<leader>sT"] = ":Telescope current_buffer_fuzzy_find<cr>",
    ["<leader>sF"] = ':lua require("telescope.builtin").find_files({hidden=true, no_ignore=true, find_command=rg})<cr>',
    ["<leader>si"] = ":Telescope media_files<cr>",
    ["<leader>sn"] = ":lua require 'telescope'.extensions.file_browser.file_browser()<CR>", --nnn nexttime?
    ["<leader>bt"] = ":Telescope buffers<CR>",
  }

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
  -- lvim.builtin.which_key.mappings["n"] = {
  --   name = "+package.json",
  --   s = { ":lua require('package-info').show()<cr>", "show outdated packages" },
  --   d = { ":lua require('package-info').delete()<cr>", "delete package" },
  --   p = { ":lua require('package-info').change_version()<cr>", "change package version" },
  --   i = { ":lua require('package-info').install()<cr>", "install new package" },
  --   r = { ":lua require('package-info').reinstall()<cr>", "reinstall package" },
  -- }

end

M.set_glow_keymaps = function ()
vim.cmd [[ noremap <leader>G :Glow<CR> ]]

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

M.set_sidebar_keymaps = function()
  if lvim.builtin.sidebar.active then
    lvim.keys.normal_mode["<leader>E"] = ":SidebarNvimToggle<CR>"
  end
end

M.set_lightspeed_keymaps = function()
  vim.cmd [[
nmap s <Plug>Lightspeed_s
nmap S <Plug>Lightspeed_S
nmap <expr> f reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_f" : "f"
nmap <expr> F reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_F" : "F"
nmap <expr> t reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_t" : "t"
nmap <expr> T reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_T" : "T"
  ]]
end



return M

