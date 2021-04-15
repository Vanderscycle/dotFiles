" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer and git status
    Plug 'scrooloose/NERDTree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'
    " EMMET improves HTML & CSS workflows
    Plug 'mattn/emmet-vim' 
    " snippets
    Plug 'honza/vim-snippets'
    " icons for NERDtree files
    Plug 'ryanoasis/vim-devicons'
    " fzf (need to look a tutorial on how to use it)
    Plug 'junegunn/fzf', { 'do': { -> fzf#instal() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter'
    " git integration
    Plug 'tpope/vim-fugitive'
    " Linter
    Plug 'dense-analysis/ale'
    " theme
    "Plug 'joshdick/onedark.vim'
    "Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'drewtempelmeyer/palenight.vim'
    " status line theme
    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-airline/vim-airline'
    " Code Runner but for Vim
    " Running the plugins causes alot of issues 
    "Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
    " multiple cursors
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    " Calendar integration and planning tools
    Plug 'itchyny/calendar.vim'
    Plug 'vimwiki/vimwiki'
    " Intellisense
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
     " On-demand lazy load
    Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
    " ranger in vim (leader f)
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    " output in a different window
    Plug 'tpope/vim-dispatch'
    " because I use conda
    Plug 'cjrh/vim-conda'
    " shows the indent
    Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
    
    call plug#end()

" need to find a way y allow for both using an added char
" "autocmd FileType python let b:dispatch = 'pylint -f parseable %'
autocmd FileType python let b:dispatch = 'python3 %'
" ALE (move later)
let g:ale_fixers = {
      \ 'python': ['pylint', 'autopep8', 'isort'],
      \ }
" space + q allows you to close a buffer without closing its window
"https://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" found using checkhealth
" Python path (we are using Conda to control our environment)
"let g:python_host_prog = expand("/home/henri/miniconda2/envs/nvimpy2/bin/python")
let g:loaded_python_provider = 0
let g:python3_host_prog = expand('/home/henri/miniconda2/bin/python')
"let g:python3_host_prog = expand('~/miniconda2/envs/neuralDomains/bin/python')

"let g:python3_host_prog = expand('~/miniconda2/envs/NNScraper/bin/python')

"Autosave
"autocmd TextChanged,TextChangedI * silent write

" Enables it to work (both powerline and airline)
set laststatus=2
" set t_Co=256

" Where was that from again?
if has("gui_running")
else
  nnoremap <Leader>d :GFiles<Enter>
endif
