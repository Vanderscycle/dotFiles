local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- dont copy any deleted text , this is disabled by default so uncomment the below mappings if you want them
--[[ remove this line

map("n", "dd", [=[ "_dd ]=], opt)
map("v", "dd", [=[ "_dd ]=], opt)
map("v", "x", [=[ "_x ]=], opt)

 this line too ]]
--

-- OPEN TERMINALS --
map("n", "<C-l>", [[<Cmd>vnew term://zsh <CR>]], opt) -- term over right
map("n", "<C-x>", [[<Cmd> split term://zsh | resize 10 <CR>]], opt) --  term bottom
map("n", "<C-t>t", [[<Cmd> tabnew | term <CR>]], opt) -- term newtab

-- copy whole file content
map("n", "<C-a>", [[ <Cmd> %y+<CR>]], opt)

-- toggle numbers
map("n", "<leader>n", [[ <Cmd> set nu!<CR>]], opt)

-- Truezen.nvim (leader z)
map("n", "<leader>za", ":TZAtaraxis<CR>", opt)
map("n", "<leader>zm", ":TZMinimalist<CR>", opt)
map("n", "<leader>zf", ":TZFocus<CR>", opt)

map("n", "<C-s>", ":w <CR>", opt)
-- vim.cmd("inoremap jh <Esc>")

-- Commenter Keybinding
map("n", "<leader>/", ":CommentToggle<CR>", opt)
map("v", "<leader>/", ":CommentToggle<CR>", opt)

map("n", "<C-q>", ":bp<bar>sp<bar>bn<bar>bd! <CR>", opt)

-- compe stuff

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn["compe#complete"]()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

function _G.completions()
    local npairs = require("nvim-autopairs")
    if vim.fn.pumvisible() == 1 then
        if vim.fn.complete_info()["selected"] ~= -1 then
            return vim.fn["compe#confirm"]("<CR>")
        end
    end
    return npairs.check_break_line_char()
end

--  compe mappings
map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("i", "<CR>", "v:lua.completions()", {expr = true})

-- nvimtree
map("n", "<C-n>", ":NvimTreeToggle<CR>", opt)

-- format code
map("n", "<Leader>p", [[<Cmd> Neoformat<CR>]], opt)

-- dashboard stuff leader d
map("n", "<Leader>db", [[<Cmd> Dashboard<CR>]], opt)
map("n", "<Leader>dn", [[<Cmd> DashboardNewFile<CR>]], opt)
map("n", "<Leader>dm", [[<Cmd> DashboardJumpMarks<CR>]], opt)
-- map("n", "<Leader>ci", ":e ~/.config/nvim/init.lua<CR>", opt)
-- map("n", "<Leader>cm", ":e ~/.config/nvim/lua/mappings.lua<CR>", opt)
-- map("n", "<Leader>ch", ":e ~/.config/nvim/lua/highlights.lua<CR>", opt)
-- map("n", "<C-s>l", [[<Cmd> SessionLoad<CR>]], opt)
-- map("n", "<C-s>s", [[<Cmd> SessionSave<CR>]], opt)

--telescope leader f
-- buffer wide
map("n", "<Leader>fb", [[<Cmd>Telescope buffers<CR>]], opt)
map("n", "<Leader>fsw", [[<Cmd>Telescope live_grep<CR>]], opt) --workspace
map("n", "<Leader>fsd", [[<Cmd>Telescope current_buffer_fuzzy_find<CR>]], opt) --document
map("n", "<leader>fw", [[<Cmd>Telescope lsp_workspace_diagnostics <CR>]])
map("n", "<leader>fd", [[<Cmd>Telescope lsp_document_diagnostics <CR>]])
map("n", "<leader>fn", ":TodoTelescope<CR>")
-- file specific
map("n", "<Leader>ft", [[<Cmd>Telescope file_browser<CR>]], opt) --system wide
map("n", "<Leader>ff", [[<Cmd>Telescope find_files<CR>]], opt) -- directory wide
map("n", "<Leader>fo", [[<Cmd>Telescope oldfiles<CR>]], opt)
map("n", "<Leader>fl", [[<Cmd>Telescope search_dootfiles<CR>]], opt) --f lua
--git
--map("n", "<Leader>fgcd", [[<Cmd>Telescope git_bcommits<CR>]], opt)
map("n", "<Leader>fgc", [[<Cmd>Telescope git_commits<CR>]], opt) --
map("n", "<Leader>fgs", [[<Cmd>Telescope git_status<CR>]], opt)
map("n", "<Leader>fgb", [[<Cmd>Telescope git_branches<CR>]], opt)
-- misc
map("n", "<Leader>fhh", [[<Cmd>Telescope help_tags<CR>]], opt)
map("n", "<Leader>fhb", [[<Cmd>Telescope builtin<CR>]], opt)
map("n", "<Leader>fp", [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]], opt)

--https://github.com/ThePrimeagen/.dotfiles/blob/master/nvim/.config/nvim/plugin/navigation.vim
local localQuickFixList = 0
local globalQuickFixList = 0
local api = vim.api

local function ToggleQFList(global)
    if global == 1 then
        if globalQuickFixList == 1 then
            globalQuickFixList = 0
            return api.nvim_command("cclose")

        else
            globalQuickFixList = 1
            return api.nvim_command("copen")
        end
    else
         if localQuickFixList == 1 then
            localQuickFixList = 0
            return api.nvim_command("lclose")
        else
            localQuickFixList = 1
            return api.nvim_command("lopen")
        end
    end
end

--quickfix lists
--local (/ is a local) ( <C-l> telescope sends it to a local list)
map("n","<leader>k",":lnext<CR>zz",opt)--why zz? (center this line)
map("n","<leader>j",":lprev<CR>zz",opt)
map("n","<leader>ql",":call ToggleQFList(0)<CR>")

--global ( <C-q> telescope sends it to a global list)
map("n","<M-k>",":cnext<CR>zz",opt)--why zz?
map("n","<M-j>",":cprev<CR>zz",opt)
map("n","<leader>qg",":call ToggleQFList(1)<CR>")

-- bufferline tab stuff
map("n", "<S-t>", ":tabnew<CR>", opt) -- new tab
map("n", "<S-x>", ":bd!<CR>", opt) -- close tab

-- move between tabs
map("n", "<TAB>", [[<Cmd>BufferLineCycleNext<CR>]], opt)
map("n", "<S-TAB>", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
map("n", "<S-TAB>", [[<Cmd>BufferLineCyclePrev<CR>]], opt)

-- better window navidation
map("n","<C-h>", "<C-w>h" , opt)
map("n","<C-j>", "<C-w>j" , opt)
map("n","<C-k>", "<C-w>k" , opt)
map("n","<C-l>", "<C-w>l" , opt)

map("i", "jk", "<Esc>", opt)
map("i", "kj", "<Esc>", opt)

--better tabing
map("v", "<","<gv", opt)
map("v", ">",">gv", opt)

-- vimwiki/markdown preview leader w
map("n","<leader>w[",":MarkdownPreview<CR>",opt)
map("n","<leader>w-",":MarkdownPreviewStop<CR>",opt)
