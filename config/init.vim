" Don't use compatibility mode
set nocompatible

" syntax for files
syntax on

" line numbers
set number

" Special characters for endline etc
set list
set listchars=trail:·,tab:▸\ ,eol:¬

" indentation for specific file types
filetype plugin indent on
"
" tab handling
set shiftwidth=4
set tabstop=4  "tab is displayed as 4 spaces
set smarttab

" keep the cursor in the screen center
set scrolloff=999

" highligth cursor row and column
set cursorline
set cursorcolumn

" mouse settings
set mouse=a

" search updates
set hlsearch
set incsearch
set smartcase

" folding
set foldmethod=syntax
noremap <space> za

" tab switch
noremap <s-l> gt
noremap <s-h> gT

" remap some Editor commands
command! E Explore
command! Ve Vexplore
command! Te Texplore
command! He Hexplore
command! Le Lexplore
command! Se Sexplore

" map leader keys (should be used in a new plugins)
let mapleader=","
let maplocalleader=","

" beter :xx<tab> completion
set wildmenu

" set the proper shell
set shell=/bin/bash

" load all necessary plugins
packloadall
" load all helptads (errors will be ignored)
silent! helptags ALL

" jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" close previews by escape
"au VimEnter * nmap <Esc> :pclose<cr>


" temporary files
set backupdir=~/.nvim-temp,.
set directory=~/.nvim-temp,.
set viminfo='20,\"50,n~/.nvim-temp/_viminfo
set viewdir=~/.nvim-temp/viewdir/

" omni completion
" remap ctrl + space to code completion
inoremap <c-@> <c-x><c-o>
" File completion with crtl + f
inoremap <c-f> <c-x><c-f>
" closes preview after completion
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" always display status line
set laststatus=2

"" enabled 256 colors
set t_Co=256

""" Plugin section
