" auto-install vim-plug
if empty(glob('~/.cnfig/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
" comments
"
call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer and git status
    Plug 'scrooloose/NERDTree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " EMMET improves HTML & CSS workflows
    Plug 'mattn/emmet-vim' 
    " icons for NERDtree files
    Plug 'ryanoasis/vim-devicons'
    " fzf (need to look a tutorial on how to use it)
    Plug 'junegunn/fzf', { 'do': { -> fzf#instal() } }
    Plug 'junegunn/fzf.vim'
    " git integration
    Plug 'tpope/vim-fugitive'
    " Linter
    Plug 'dense-analysis/ale'
    " theme
    Plug 'joshdick/onedark.vim'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'drewtempelmeyer/palenight.vim'
    " status line theme
    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-airline/vim-airline'
    " Code Runner but for Vim
    Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
    " multiple cursors
    " Plug 'terryma/vim-multiple-cursors' "deprrecated
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    " Calendar integration and planning tools
    Plug 'itchyny/calendar.vim'
    Plug 'vimwiki/vimwiki'
    " Intellisense
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
     " On-demand lazy load
    Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
    " ranger in vim (leader f)
    Plug 'francoiscabrol/ranger.vim'
    Plug 'rbgrouleff/bclose.vim'
    " vimux (tmux + vim)
    Plug 'jpalardy/vim-slime', { 'for': 'python' }
    Plug 'hanschen/vim-ipython-cell', { 'for': 'python' } 
    call plug#end()

" vimux specific
map <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
" found using checkhealth
let g:python3_host_prog = expand('~/miniconda2/bin/python3')
" Autosave
autocmd TextChanged,TextChangedI <buffer> silent write

" Enables it to work (both powerline and airline)
set laststatus=2
" set t_Co=256

" Airline config
"let g:airline#extensions#tabline#enabled = 1
"set ttimeoutlen=50

" Sniprun (code runner)
" recommended shortcuts (visual)
nmap <leader>f <Plug>SnipRun
vmap f <Plug>SnipRun
nmap <leader>c :SnipReplMemoryClean<CR>

" Where was that from again?
if has("gui_running")
else
  nnoremap <Leader>d :GFiles<Enter>
endif
