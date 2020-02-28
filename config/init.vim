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

""" Plugin installation
call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'
call plug#end()


""" Plugin related configuration

"" gruvbox
set t_Co=256
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = "soft"
let g:gruvbox_italicize_comments = 1
colorscheme gruvbox

"" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = 'L'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" airline bugs...
set laststatus=2

"" ale plugin
" fixers
let g:ale_fixers = {
\  'rust': ['rustfmt', 'remove_trailing_lines', 'trim_whitespace'],
\  'python': ['black', 'isort', 'remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_fix_on_save = 1

" signs
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
"highlight ALEErrorSign ctermbg=NONE ctermfg=red
"highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
let g:ale_completion_enabled = 0

" python
let g:ale_python_auto_pipenv = 0
let g:ale_virtualenv_dir_names = [$VIRTUAL_ENV]

" Try to read flake8 options from an env variable
if !empty($FLAKE8_OPTIONS)
	let g:ale_python_flake8_options = $FLAKE8_OPTIONS
else
	let g:ale_python_flake8_options = "--ignore=E203 --max-line-length=100"
endif

" Try to read black options from an env variable
if !empty($BLACK_OPTIONS)
	let g:ale_python_black_options = $BLACK_OPTIONS
else
	let g:ale_python_black_options = "--line-length 100"
endif
"
" Try to read isort options from an env variable
if !empty($ISORT_OPTIONS)
	let g:ale_python_isort_options = $ISORT_OPTIONS
else
	let g:ale_python_isort_options = "--line-width 100"
endif

" mypy search path
let g:ale_python_mypy_options = "--cache-dir ~/.mypy_cache --python-executable python --ignore-missing-imports"

" rust
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
let g:ale_rust_cargo_clippy_options = '--all-features -- -W clippy::style -W clippy::correctness -W clippy::complexity -W clippy::pedantic -W clippy::nursery -W clippy::perf -W clippy::cargo -A clippy::restriction -W clippy::dbg_macro -A clippy::module_name_repetitions'
let g:ale_rust_cargo_check_all_targets = 1
let g:ale_rust_rustfmt_options = "--edition 2018"
