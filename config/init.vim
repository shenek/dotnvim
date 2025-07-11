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

" Override tabs for some kind of files
augroup file_type_overrides
	autocmd!
	au FileType vue setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
	au FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
	au FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
augroup END

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
noremap <space> za
augroup remember_folds
	autocmd!
		au BufWinLeave ?* mkview 1
		au BufWinEnter ?* silent! loadview 1
augroup END

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
let g:netrw_home='~/.nvim-temp/'

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
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'ncm2/float-preview.nvim'
Plug 'machakann/vim-sandwich'
Plug 'machakann/vim-highlightedyank'
Plug 'projectfluent/fluent.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
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

" enable virtualtext cursor
let g:ale_virtualtext_cursor = 1

" fixers
let g:ale_fixers = {
\  'rust': ['rustfmt', 'remove_trailing_lines', 'trim_whitespace'],
\  'python': ['ruff', 'black', 'remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_fix_on_save = 1

" linters
let g:ale_linters = {
\  'rust': ['cargo'],
\  'python': ['ruff', 'mypy', 'bandit'],
\}

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
endif

" Try to read black options from an env variable
if !empty($BLACK_OPTIONS)
	let g:ale_python_black_options = $BLACK_OPTIONS
endif
"
" Try to read isort options from an env variable
if !empty($ISORT_OPTIONS)
	let g:ale_python_isort_options = $ISORT_OPTIONS
endif

" mypy search path
let g:ale_python_mypy_options = "--cache-dir ~/.mypy_cache --python-executable python --ignore-missing-imports"

" rust
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
let g:ale_rust_cargo_clippy_options = '--all-features -- -W clippy::style -W clippy::correctness -W clippy::complexity -W clippy::pedantic -W clippy::nursery -W clippy::perf -W clippy::cargo -A clippy::restriction -W clippy::dbg_macro -A clippy::module_name_repetitions'
let g:ale_rust_cargo_check_all_targets = 1
let g:ale_rust_rustfmt_options = "--edition 2018"


"" gitgutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '≈'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '--'
let g:gitgutter_sign_modified_removed = '≈-'
let g:gitgutter_highlight_linenrs = 1

autocmd BufWritePost * GitGutter " update on save

"" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_auto_colors = 0
"hi IndentGuidesOdd  ctermbg=238
"hi IndentGuidesEven ctermbg=239
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

"" fzf.vim
let g:fzf_command_prefix = 'FZF'
" Disables preview window
let g:fzf_preview_window = ''
nmap fr :FZFRg<cr>
nmap ff :FZFFiles<cr>
nmap fg :FZFGitFiles<cr>
nmap fw :FZFWindows<cr>
nmap fh :FZFHistory<cr>

"" nvim-lspconfig
lua <<EOF
local lspconfig = require('lspconfig');
local capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig.pylsp.setup{ capabilities = capabilities }
lspconfig.rust_analyzer.setup{ capabilities = capabilities }

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

require'lspconfig'.vuels.setup{}

-- AutoCompletion
local cmp = require 'cmp'
cmp.setup {
    snippet = {},
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
        -- C-b (back) C-f (forward) for snippet placeholder navigation.
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            --elseif luasnip.expand_or_jumpable() then
            --    luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            --elseif luasnip.jumpable(-1) then
            --    luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp', group_index = 1 },
        { name = 'path', group_index = 2 },
        { name = 'buffer', group_index = 3 },
    },
}

EOF

"" float-preview.nvim
let g:float_preview#docked = 0

"" vim-highlightedyank
let g:highlightedyank_highlight_duration = -1

"" treesitter
lua require'nvim-treesitter'.setup()
lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = "all",
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	indent = {
		enable = true,
		disable = { "yaml", "python", },  -- treesitter doesn't currently work well for python
	},
}
EOF
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
