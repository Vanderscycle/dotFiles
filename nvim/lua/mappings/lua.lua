local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- dont copy any deleted text , this is disabled by default so uncomment the below mappings if you want them!
--[[

map("n", "dd", [=[ "_dd ]=], opt)
map("v", "dd", [=[ "_dd ]=], opt)
map("v", "x", [=[ "_x ]=], opt)

]]
-- copy any selected text with pressing y
map("", "<leader>c", '"+y')

-- OPEN TERMINALS --
map("n", "<C-l>", [[<Cmd>vnew term://zsh <CR>]], opt) -- open term over right
map("n", "<C-x>", [[<Cmd> split term://zsh | resize 10 <CR>]], opt) -- open term bottom

-- COPY EVERYTHING --
map("n", "<C-a>", [[ <Cmd> %y+<CR>]], opt)

-- toggle numbers ---
map("n", "<leader>n", [[ <Cmd> set nu!<CR>]], opt)

-- toggle truezen.nvim's ataraxis mode
map("n", "<leader>z", [[ <Cmd> TZAtaraxis<CR>]], opt)

-- better window navidation
map("n","<C-h>", "<C-w>h" , opt)
map("n","<C-j>", "<C-w>j" , opt)
map("n","<C-k>", "<C-w>k" , opt)
map("n","<C-l>", "<C-w>l" , opt)

map("i", "jk", "<Esc>", opt)
map("i", "kj", "<Esc>", opt)

-- tab to move between buffers
map("n", "<TAB>", ":bnext<CR>",opt)
map("n", "<S-TAB>", ":bprevious<CR>",opt)

-- alternate way to save
map("n","<C-s>",":w<CR>", opt)
map("n","<C-q>",":wq!<CR>", opt)

--better tabing
map("v", "<","<gv", opt)
map("v", ">",">gv", opt)

-- closing buffer
map("n","<leader>q",":bp<bar>sp<bar>bn<bar>bd<CR>", opt)

-- snipRun
map("n","<leader>sa","ggVG:SnipRun<CR>", opt)
map("n","<leader>sr",":SnipRun<CR>", opt) -- single line
map("v","<leader>sl",":SnipRun<CR>", opt) -- block of code
map("n","<leader>sc",":SnipClose<CR>", opt) -- clear outputs
map("n","<leader>sz",":SnipReset<CR>", opt)

--vimspector
-- https://alpha2phi.medium.com/neovim-debugging-application-70c525754064
map("n", "<leader>vl", ":call vimspector#Launch()<CR>")
map("n", "<leader>vr", ":VimspectorReset<CR>")
map("n", "<leader>ve", ":VimspectorEval")
map("n", "<leader>vw", ":VimspectorWatch")
map("n", "<leader>vo", "<Plug>VimspectorBalloonEval")
map("n", "<leader>vo", ":vimspectorShowOutput")

