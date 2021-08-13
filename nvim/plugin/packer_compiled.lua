-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/henri/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/henri/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/henri/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/henri/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/henri/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["AutoSave.nvim"] = {
    config = { "\27LJ\1\0020\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\21plugins.autosave\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/AutoSave.nvim"
  },
  ["DAPInstall.nvim"] = {
    loaded = true,
    path = "/home/henri/.local/share/nvim/site/pack/packer/start/DAPInstall.nvim"
  },
  ["FTerm.nvim"] = {
    config = { "\27LJ\1\0023\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\nFTerm\frequire\0" },
    loaded = true,
    path = "/home/henri/.local/share/nvim/site/pack/packer/start/FTerm.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugins.luasnip\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/LuaSnip",
    wants = { "friendly-snippets" }
  },
  ["TrueZen.nvim"] = {
    commands = { "TZAtaraxis", "TZMinimalist", "TZFocus" },
    config = { "\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugins.zenmode\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/TrueZen.nvim"
  },
  ["better-escape.vim"] = {
    config = { "\27LJ\1\2=\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\vescape\19plugins.others\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/better-escape.vim"
  },
  ["dashboard-nvim"] = {
    commands = { "Dashboard", "DashboardNewFile", "DashboardJumpMarks", "SessionLoad", "SessionSave" },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/dashboard-nvim"
  },
  ["diffview.nvim"] = {
    commands = { "DiffviewOpen" },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/diffview.nvim"
  },
  ["friendly-snippets"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/friendly-snippets"
  },
  ["galaxyline.nvim"] = {
    config = { "\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23plugins.statusline\frequire\0" },
    load_after = {
      ["nvim-base16.lua"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/galaxyline.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\1\0020\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\21plugins.gitsigns\frequire\0" },
    load_after = {
      ["plenary.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim"
  },
  ["lsp_signature.nvim"] = {
    config = { "\27LJ\1\2@\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\14signature\19plugins.others\frequire\0" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    config = { "\27LJ\1\2>\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\flspkind\19plugins.others\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\1\0026\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\27plugins.lspsaga_config\frequire\0" },
    loaded = true,
    path = "/home/henri/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  neoformat = {
    commands = { "Neoformat" },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/neoformat"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\1\2@\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\14neoscroll\19plugins.others\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/neoscroll.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\1\0021\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\22plugins.autopairs\frequire\0" },
    load_after = {
      ["nvim-compe"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/nvim-autopairs"
  },
  ["nvim-base16.lua"] = {
    after = { "galaxyline.nvim", "nvim-bufferline.lua", "nvim-web-devicons" },
    config = { "\27LJ\1\2%\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\ntheme\frequire\0" },
    load_after = {
      ["packer.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/nvim-base16.lua"
  },
  ["nvim-bufferline.lua"] = {
    config = { "\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23plugins.bufferline\frequire\0" },
    load_after = {
      ["nvim-base16.lua"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/nvim-bufferline.lua"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\1\2@\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\14colorizer\19plugins.others\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua"
  },
  ["nvim-comment"] = {
    commands = { "CommentToggle" },
    config = { "\27LJ\1\2>\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\fcomment\19plugins.others\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/nvim-comment"
  },
  ["nvim-compe"] = {
    after = { "nvim-autopairs", "tabout.nvim" },
    after_files = { "/home/henri/.local/share/nvim/site/pack/packer/opt/nvim-compe/after/plugin/compe.vim" },
    config = { "\27LJ\1\2-\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\18plugins.compe\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/nvim-compe",
    wants = { "LuaSnip" }
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/henri/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-lspconfig"] = {
    after = { "lsp_signature.nvim" },
    config = { "\27LJ\1\0021\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\22plugins.lspconfig\frequire\0" },
    load_after = {
      ["nvim-lspinstall"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    after = { "nvim-lspconfig" },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/nvim-lspinstall"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeToggle" },
    config = { "\27LJ\1\0020\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\21plugins.nvimtree\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23plugins.treesitter\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\1\2-\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\18plugins.icons\frequire\0" },
    load_after = {
      ["nvim-base16.lua"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    after = { "nvim-base16.lua" },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    after = { "popup.nvim", "gitsigns.nvim" },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/plenary.nvim"
  },
  ["popup.nvim"] = {
    load_after = {
      ["plenary.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/popup.nvim"
  },
  ["tabout.nvim"] = {
    config = { "\27LJ\1\2�\2\0\0\4\0\f\0\0234\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0002\2\a\0003\3\4\0;\3\1\0023\3\5\0;\3\2\0023\3\6\0;\3\3\0023\3\a\0;\3\4\0023\3\b\0;\3\5\0023\3\t\0;\3\6\2:\2\n\0012\2\0\0:\2\v\1>\0\2\1G\0\1\0\fexclude\ftabouts\1\0\2\topen\6{\nclose\6}\1\0\2\topen\6[\nclose\6]\1\0\2\topen\6(\nclose\6)\1\0\2\topen\6`\nclose\6`\1\0\2\topen\6\"\nclose\6\"\1\0\2\topen\6'\nclose\6'\1\0\a\21ignore_beginning\2\15act_as_tab\2\21act_as_shift_tab\1\15completion\2\21enable_backwards\2\21backwards_tabkey\f<S-Tab>\vtabkey\n<Tab>\nsetup\vtabout\frequire\0" },
    load_after = {
      ["nvim-compe"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/tabout.nvim",
    wants = { "nvim-treesitter" }
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/henri/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/home/henri/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "\27LJ\1\0021\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\22plugins.telescope\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { '\27LJ\1\2�\4\0\0\5\0%\0-4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\23\0003\2\6\0003\3\3\0003\4\4\0:\4\5\3:\3\a\0023\3\b\0003\4\t\0:\4\5\3:\3\n\0023\3\v\0003\4\f\0:\4\5\3:\3\r\0023\3\14\0003\4\15\0:\4\5\3:\3\16\0023\3\17\0003\4\18\0:\4\5\3:\3\19\0023\3\20\0003\4\21\0:\4\5\3:\3\22\2:\2\24\0013\2\26\0003\3\25\0:\3\27\0023\3\28\0:\3\29\0023\3\30\0:\3\31\0023\3 \0:\3!\0023\3"\0:\3#\2:\2$\1>\0\2\1G\0\1\0\vcolors\fdefault\1\2\0\0\f#B48EAD\thint\1\2\0\0\f#A3BE8C\tinfo\1\2\0\0\f#5E81AC\fwarning\1\2\0\0\f#D08770\nerror\1\0\0\1\2\0\0\f#BF616A\rkeywords\1\0\0\tNOTE\1\2\0\0\tINFO\1\0\2\ncolor\thint\ticon\t \tPERF\1\4\0\0\nOPTIM\16PERFORMANCE\rOPTIMIZE\1\0\2\ncolor\fdefault\ticon\t \tWARN\1\3\0\0\fWARNING\vDANGER\1\0\2\ncolor\fwarning\ticon\t \tHACK\1\2\0\0\tTEMP\1\0\2\ncolor\f#EBCB8B\ticon\t \tTODO\1\2\0\0\tNOTE\1\0\2\ncolor\tinfo\ticon\t \bFIX\1\0\0\balt\1\5\0\0\nFIXME\bBUG\nFIXIT\nISSUE\1\0\2\ncolor\nerror\ticon\t \nsetup\18todo-comments\frequire\0' },
    loaded = true,
    path = "/home/henri/.local/share/nvim/site/pack/packer/start/todo-comments.nvim"
  },
  ["vim-fugitive"] = {
    commands = { "Git", "G" },
    loaded = false,
    needs_bufread = true,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/vim-fugitive"
  },
  ["vim-matchup"] = {
    after_files = { "/home/henri/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    loaded = false,
    needs_bufread = true,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/vim-matchup"
  },
  vimwiki = {
    commands = { "VimwikiIndex" },
    config = { "\27LJ\1\2�\1\0\0\3\0\5\0\v4\0\0\0007\0\1\0'\1\0\0:\1\2\0004\0\0\0007\0\1\0002\1\3\0003\2\4\0;\2\1\1:\1\3\0G\0\1\0\1\0\5\vsyntax\rmarkdown\16auto_export\3\1\bext\b.md\14path_html#~/Documents/dotFiles/obsidian/\tpath#~/Documents/dotFiles/obsidian/\17vimwiki_list\23vimwiki_global_ext\6g\bvim\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/henri/.local/share/nvim/site/pack/packer/opt/vimwiki"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\1\2;\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/home/henri/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^diffview"] = "diffview.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Setup for: nvim-bufferline.lua
time([[Setup for nvim-bufferline.lua]], true)
try_loadstring("\27LJ\1\2;\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\15bufferline\rmappings\frequire\0", "setup", "nvim-bufferline.lua")
time([[Setup for nvim-bufferline.lua]], false)
-- Setup for: telescope.nvim
time([[Setup for telescope.nvim]], true)
try_loadstring("\27LJ\1\2:\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\14telescope\rmappings\frequire\0", "setup", "telescope.nvim")
time([[Setup for telescope.nvim]], false)
-- Setup for: dashboard-nvim
time([[Setup for dashboard-nvim]], true)
try_loadstring("\27LJ\1\2X\0\0\2\0\4\0\t4\0\0\0%\1\1\0>\0\2\0014\0\0\0%\1\2\0>\0\2\0027\0\3\0>\0\1\1G\0\1\0\14dashboard\rmappings\22plugins.dashboard\frequire\0", "setup", "dashboard-nvim")
time([[Setup for dashboard-nvim]], false)
-- Setup for: indent-blankline.nvim
time([[Setup for indent-blankline.nvim]], true)
try_loadstring("\27LJ\1\2@\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\14blankline\19plugins.others\frequire\0", "setup", "indent-blankline.nvim")
time([[Setup for indent-blankline.nvim]], false)
-- Setup for: neoformat
time([[Setup for neoformat]], true)
try_loadstring("\27LJ\1\2:\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\14neoformat\rmappings\frequire\0", "setup", "neoformat")
time([[Setup for neoformat]], false)
-- Setup for: nvim-comment
time([[Setup for nvim-comment]], true)
try_loadstring("\27LJ\1\2=\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\17comment_nvim\rmappings\frequire\0", "setup", "nvim-comment")
time([[Setup for nvim-comment]], false)
-- Setup for: nvim-tree.lua
time([[Setup for nvim-tree.lua]], true)
try_loadstring("\27LJ\1\0029\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\rnvimtree\rmappings\frequire\0", "setup", "nvim-tree.lua")
time([[Setup for nvim-tree.lua]], false)
-- Setup for: TrueZen.nvim
time([[Setup for TrueZen.nvim]], true)
try_loadstring("\27LJ\1\0028\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\ftruezen\rmappings\frequire\0", "setup", "TrueZen.nvim")
time([[Setup for TrueZen.nvim]], false)
-- Setup for: vim-fugitive
time([[Setup for vim-fugitive]], true)
try_loadstring("\27LJ\1\0029\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\rfugitive\rmappings\frequire\0", "setup", "vim-fugitive")
time([[Setup for vim-fugitive]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\1\2;\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring('\27LJ\1\2�\4\0\0\5\0%\0-4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\23\0003\2\6\0003\3\3\0003\4\4\0:\4\5\3:\3\a\0023\3\b\0003\4\t\0:\4\5\3:\3\n\0023\3\v\0003\4\f\0:\4\5\3:\3\r\0023\3\14\0003\4\15\0:\4\5\3:\3\16\0023\3\17\0003\4\18\0:\4\5\3:\3\19\0023\3\20\0003\4\21\0:\4\5\3:\3\22\2:\2\24\0013\2\26\0003\3\25\0:\3\27\0023\3\28\0:\3\29\0023\3\30\0:\3\31\0023\3 \0:\3!\0023\3"\0:\3#\2:\2$\1>\0\2\1G\0\1\0\vcolors\fdefault\1\2\0\0\f#B48EAD\thint\1\2\0\0\f#A3BE8C\tinfo\1\2\0\0\f#5E81AC\fwarning\1\2\0\0\f#D08770\nerror\1\0\0\1\2\0\0\f#BF616A\rkeywords\1\0\0\tNOTE\1\2\0\0\tINFO\1\0\2\ncolor\thint\ticon\t \tPERF\1\4\0\0\nOPTIM\16PERFORMANCE\rOPTIMIZE\1\0\2\ncolor\fdefault\ticon\t \tWARN\1\3\0\0\fWARNING\vDANGER\1\0\2\ncolor\fwarning\ticon\t \tHACK\1\2\0\0\tTEMP\1\0\2\ncolor\f#EBCB8B\ticon\t \tTODO\1\2\0\0\tNOTE\1\0\2\ncolor\tinfo\ticon\t \bFIX\1\0\0\balt\1\5\0\0\nFIXME\bBUG\nFIXIT\nISSUE\1\0\2\ncolor\nerror\ticon\t \nsetup\18todo-comments\frequire\0', "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: FTerm.nvim
time([[Config for FTerm.nvim]], true)
try_loadstring("\27LJ\1\0023\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\nFTerm\frequire\0", "config", "FTerm.nvim")
time([[Config for FTerm.nvim]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
try_loadstring("\27LJ\1\0026\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\27plugins.lspsaga_config\frequire\0", "config", "lspsaga.nvim")
time([[Config for lspsaga.nvim]], false)
-- Conditional loads
time("Condition for { 'AutoSave.nvim' }", true)
if
try_loadstring("\27LJ\1\2;\0\0\1\0\3\0\t4\0\0\0007\0\1\0007\0\2\0\n\0\2\0T\0\2�)\0\1\0T\1\1�)\0\2\0H\0\2\0\14auto_save\6g\bvim\0", "condition", '{ "AutoSave.nvim" }')
then
time("Condition for { 'AutoSave.nvim' }", false)
time([[packadd for AutoSave.nvim]], true)
		vim.cmd [[packadd AutoSave.nvim]]
	time([[packadd for AutoSave.nvim]], false)
	-- Config for: AutoSave.nvim
	time([[Config for AutoSave.nvim]], true)
	try_loadstring("\27LJ\1\0020\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\21plugins.autosave\frequire\0", "config", "AutoSave.nvim")
	time([[Config for AutoSave.nvim]], false)
else
time("Condition for { 'AutoSave.nvim' }", false)
end

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file DashboardNewFile lua require("packer.load")({'dashboard-nvim'}, { cmd = "DashboardNewFile", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file TZAtaraxis lua require("packer.load")({'TrueZen.nvim'}, { cmd = "TZAtaraxis", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file DiffviewOpen lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file SessionSave lua require("packer.load")({'dashboard-nvim'}, { cmd = "SessionSave", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file G lua require("packer.load")({'vim-fugitive'}, { cmd = "G", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file VimwikiIndex lua require("packer.load")({'vimwiki'}, { cmd = "VimwikiIndex", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file CommentToggle lua require("packer.load")({'nvim-comment'}, { cmd = "CommentToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file TZFocus lua require("packer.load")({'TrueZen.nvim'}, { cmd = "TZFocus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file SessionLoad lua require("packer.load")({'dashboard-nvim'}, { cmd = "SessionLoad", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file Neoformat lua require("packer.load")({'neoformat'}, { cmd = "Neoformat", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file Dashboard lua require("packer.load")({'dashboard-nvim'}, { cmd = "Dashboard", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file NvimTreeToggle lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file Git lua require("packer.load")({'vim-fugitive'}, { cmd = "Git", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file TZMinimalist lua require("packer.load")({'TrueZen.nvim'}, { cmd = "TZMinimalist", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file DashboardJumpMarks lua require("packer.load")({'dashboard-nvim'}, { cmd = "DashboardJumpMarks", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au WinScrolled * ++once lua require("packer.load")({'neoscroll.nvim'}, { event = "WinScrolled *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'packer.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au CursorMoved * ++once lua require("packer.load")({'vim-matchup'}, { event = "CursorMoved *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-treesitter', 'indent-blankline.nvim', 'plenary.nvim', 'nvim-colorizer.lua', 'nvim-lspinstall'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au InsertCharPre * ++once lua require("packer.load")({'LuaSnip', 'friendly-snippets'}, { event = "InsertCharPre *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'better-escape.vim', 'nvim-compe'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufEnter * ++once lua require("packer.load")({'lspkind-nvim'}, { event = "BufEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
