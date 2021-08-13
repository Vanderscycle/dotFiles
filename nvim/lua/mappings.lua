local user_map = require("chadrc").mappings
local miscMap = user_map.misc

local M = {}
local cmd = vim.cmd

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

-- Don't copy the replaced text after pasting in visual mode
map("v", "p", '"_dP', opt)

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using :map
map("", "j", 'v:count ? "j" : "gj"', {expr = true})
map("", "k", 'v:count ? "k" : "gk"', {expr = true})
map("", "<Down>", 'v:count ? "j" : "gj"', {expr = true})
map("", "<Up>", 'v:count ? "k" : "gk"', {expr = true})

-- OPEN TERMINALS --
map("n", miscMap.openTerm_right, ":vnew +terminal | setlocal nobuflisted <CR>", opt) -- term over right
map("n", miscMap.openTerm_bottom, ":10new +terminal | setlocal nobuflisted <CR>", opt) --  term bottom
map("n", miscMap.openTerm_currentBuf, ":terminal <CR>", opt) -- term buffer

-- copy whole file content
map("n", miscMap.copywhole_file, ":%y+<CR>", opt)

-- toggle numbers
map("n", miscMap.toggle_linenr, ":set nu!<CR>", opt)

M.truezen = function()
    local m = user_map.truezen

    map("n", m.ataraxisMode, ":TZAtaraxis<CR>", opt)
    map("n", m.minimalisticmode, ":TZMinimalist<CR>", opt)
    map("n", m.focusmode, ":TZFocus<CR>", opt)
end

map("n", "<C-s>", ":w <CR>", opt)

M.comment_nvim = function()
    local m = user_map.comment_nvim.comment_toggle
    map("n", m, ":CommentToggle<CR>", opt)
    map("v", m, ":CommentToggle<CR>", opt)
end

M.nvimtree = function()
    local m = user_map.nvimtree.treetoggle

    map("n", m, ":NvimTreeToggle<CR>", opt)
end

M.neoformat = function()
    local m = user_map.neoformat.format
    map("n", m, ":Neoformat<CR>", opt)
end

M.dashboard = function()
    local m = user_map.dashboard

    map("n", m.open, ":Dashboard<CR>", opt)
    map("n", m.newfile, ":DashboardNewFile<CR>", opt)
    map("n", m.bookmarks, ":DashboardJumpMarks<CR>", opt)
    map("n", m.sessionload, ":SessionLoad<CR>", opt)
    map("n", m.sessionsave, ":SessionSave<CR>", opt)
end

M.telescope = function()
    local m = user_map.telescope

    map("n", m.live_grep, ":Telescope live_grep<CR>", opt)
    map("n", m.git_status, ":Telescope git_status <CR>", opt)
    map("n", m.git_commits, ":Telescope git_commits <CR>", opt)
    map("n", m.find_files, ":Telescope find_files <CR>", opt)
    map("n", m.media_files, ":Telescope media_files <CR>", opt)
    map("n", m.buffers, ":Telescope buffers<CR>", opt)
    map("n", m.help_tags, ":Telescope help_tags<CR>", opt)
    map("n", m.oldfiles, ":Telescope oldfiles<CR>", opt)
    map("n", m.themes, ":Telescope themes<CR>", opt)
    map("n", m.builtin, ":Telescope builtin<CR>", opt)
    map("n", m.folke_todo, ":TodoTelescop<CR>", opt)
    map("n", m.workplace_diag, ":Telescope lsp_workspace_diagnostics<CR>", opt)
    map("n", m.document_diag, ":Telescope lsp_document_diagnostics<CR>", opt)
end

M.bufferline = function()
    local m = user_map.bufferline

    map("n", m.new_buffer, ":enew<CR>", opt) -- new buffer
    map("n", m.newtab, ":tabnew<CR>", opt) -- new tab
    map("n", m.close, ":bd!<CR>", opt) -- close  buffer

    -- move between tabs

    map("n", m.cycleNext, ":BufferLineCycleNext<CR>", opt)
    map("n", m.cyclePrev, ":BufferLineCyclePrev<CR>", opt)
end

-- use ESC to turn off search highlighting
map("n", "<Esc>", ":noh<CR>", opt)

-- get out of terminal with jk
map("t", miscMap.esc_Termmode, "<C-\\><C-n>", opt)

-- Packer commands till because we are not loading it at startup
cmd("silent! command PackerCompile lua require 'pluginList' require('packer').compile()")
cmd("silent! command PackerInstall lua require 'pluginList' require('packer').install()")
cmd("silent! command PackerStatus lua require 'pluginList' require('packer').status()")
cmd("silent! command PackerSync lua require 'pluginList' require('packer').sync()")
cmd("silent! command PackerUpdate lua require 'pluginList' require('packer').update()")

M.fugitive = function()
    local m = user_map.fugitive

    map("n", m.Git, ":Git<CR>", opt)
    map("n", m.diffget_2, ":diffget //2<CR>", opt)
    map("n", m.diffget_3, ":diffget //3<CR>", opt)
    map("n", m.git_blame, ":Git blame<CR>", opt)
end
-- unmoved user
--quickfix lists
--local (/ is a local) ( <C-l> telescope sends it to a local list)
map("n","<leader>k",":lnext<CR>zz",opt)--why zz? (center this line)
map("n","<leader>j",":lprev<CR>zz",opt)
map("n","<leader>ql",":lua require('mappings').ToggleQFList(0)<CR>")

--global ( <C-q> telescope sends it to a global list)
map("n","<M-k>",":cnext<CR>zz",opt)--why zz?
map("n","<M-j>",":cprev<CR>zz",opt)
map("n","<leader>qg",":lua require('mappings').ToggleQFList(1)<CR>")

--nvim dap (necessary?)
map('n', '<leader>dc', '<cmd>lua require"dap".continue()<CR>')
map('n', '<leader>dso', '<cmd>lua require"dap".step_over()<CR>')
map('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>')
map('n', '<leader>dsx', '<cmd>lua require"dap".step_out()<CR>')
map('n', '<leader>dbt', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
map('n', '<leader>dbn', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
map('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>')
-- telescope-dap
map('n', '<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>')
map('n', '<leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>')
map('n', '<leader>dlb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>')
map('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>')
map('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>')

-- vimwiki/markdown preview leader w
map("n","<leader>w[",":MarkdownPreview<CR>",opt)
map("n","<leader>w-",":MarkdownPreviewStop<CR>",opt)

-- floating terminal
map('n', '<A-t>', '<CMD>lua require("FTerm").toggle()<CR>', opt)
map('t', '<A-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opt)

--lspsaga
map("n","<leader>lf","<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>")
map("n","<leader>la","<cmd>lua require('lspsaga.codeaction').code_action()<CR>",opt)
map("n","<leader>ld","<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>",opt)
-- map("n","<M-k>","<CMD>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>",opt)
-- map("n","<M-j>","<CMD>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>",opt)
map("n","<leader>ls","<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>",opt)
map("n","<leader>lr","<cmd>lua require('lspsaga.rename').rename()<CR>",opt)
map("n","<leader>lp","<cmd>lua require'lspsaga.provider'.preview_definition()<CR>",opt)
map("n", "[d","<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>",opt)
map("n", "]d","<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>",opt)

--close the current buffer
map("n", "<C-q>", ":bp<bar>sp<bar>bn<bar>bd! <CR>", opt)
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

local localQuickFixList = 0
local globalQuickFixList = 0
local api = vim.api
function M.ToggleQFList(global)
    if (global == 1) then
        if( globalQuickFixList == 1) then
            globalQuickFixList = 0
            return api.nvim_command("cclose")

        else
            globalQuickFixList = 1
            return api.nvim_command("copen")
        end
    else --if the local list is empty it returns an error
         if( localQuickFixList == 1) then
            localQuickFixList = 0
            return api.nvim_command("lclose")
        else
            localQuickFixList = 1
            return api.nvim_command("lopen")
        end
    end
  end
return M
