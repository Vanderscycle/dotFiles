local vim = vim;
local map = vim.api.nvim_set_keymap;

map('n', '<C-k>', ':cnext<CR>zz', { noremap = true });
map('n', '<C-j>', ':cprev<CR>zz', { noremap = true }); map('n', '<Leader>k', ':lnext<CR>zz', { noremap = true }); map('n', '<Leader>j', ':lprev<CR>zz', { noremap = true });
map('n', '<C-q>', "<cmd>lua require('specialFunc.quickFix').toggle(1)<CR>", { noremap = true, silent = true });
map('n', '<Leader>q', ":<cmd>lua require('specialFunc.quickFix').toggle(0)<CR>", { noremap = true, silent = true });

local active_list = vim.NIL;

local list_types = {
  location = 'location',
  quickfix = 'quickfix'
}

local function toggle_location_list()
  if (active_list == list_types.location) then
    vim.cmd('lclose');
    active_list = vim.NIL;
  else
    if active_list == list_types.quickfix then
      vim.cmd('cclose');
    end

    if pcall(vim.cmd, 'lopen') then
      active_list = list_types.location;
    else
      print("No location list to show");
      active_list = vim.NIL;
    end
  end
end

local function toggle_quickfix_list()
  if (active_list == list_types.quickfix) then
    vim.cmd('cclose');
    active_list = vim.NIL;
  else
    if active_list == list_types.location then
      vim.cmd('lclose');
    end

    vim.cmd('copen');
    active_list = list_types.quickfix
  end
end

local function toggle(global)
  if global == 1 then
    toggle_quickfix_list();
  else
    toggle_location_list();
  end
end

return {
  toggle = toggle
}

