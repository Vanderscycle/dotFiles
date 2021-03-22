" auto-install vim-plug
if empty(glob('~/.cnfig/nvim/autoload/plug.vim'))
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
    " EMMET improves HTML & CSS workflows
    Plug 'mattn/emmet-vim' 
    " icons for NERDtree files
    Plug 'ryanoasis/vim-devicons'
    " fzf (need to look a tutorial on how to use it)
    Plug 'junegunn/fzf', { 'do': { -> fzf#instal() } }
    Plug 'junegunn/fzf.vim'
    " git integration
    Plug 'tpope/vim-fugitive'
    Plug 'vim-airline/vim-airline'
    " Linter
    Plug 'dense-analysis/ale'
    " theme
    Plug 'joshdick/onedark.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'drewtempelmeyer/palenight.vim'
    " Code Runner but for Vim
    Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
    "
    call plug#end()

" color theme
syntax on
" colorscheme onedark
" colorscheme dracula
colorscheme palenight

if (has("termguicolors"))
  set termguicolors
endif

" lightline customization
" lightline theme
"let g:lightline = { 'colorscheme': 'onedark' }
let g:lightline = { 'colorscheme': 'palenight' }
" Enables it to work
set laststatus=2

" Sniprun (code runner)
" recommended shortcuts (visual)
nmap <leader>f <Plug>SnipRun
vmap f <Plug>SnipRun
nmap <leader>c :SnipReplMemoryClean<CR>
"NERDtree

" enable line numbers
let NERDTreeShowLineNumbers=1

" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Open a NerdTree if no file is given as CLI argument
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Exit Vim if NERDTree is the only window lft.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endife
"fxf
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)"')"
if has("gui_running")
else
  nnoremap <Leader>d :GFiles<Enter>
endif
