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
Plug 'nathanaelkane/vim-indent-guides'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'ncm2/float-preview.nvim'
Plug 'machakann/vim-sandwich'
Plug 'machakann/vim-highlightedyank'
Plug 'projectfluent/fluent.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'saghen/blink.cmp', { 'tag': 'v1.*' }
Plug 'rafamadriz/friendly-snippets'
Plug 'nvim-mini/mini.icons'
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
vim.lsp.enable('pylsp')
vim.lsp.enable('rust_analyzer')
--vim.lsp.enable('vuels')

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

-- autocompletion
require("blink.cmp").setup({
	-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
	-- 'super-tab' for mappings similar to vscode (tab to accept)
	-- 'enter' for enter to accept
	-- 'none' for no mappings
	--
	-- All presets have the following mappings:
	-- C-space: Open menu or open docs if already open
	-- C-n/C-p or Up/Down: Select next/previous item
	-- C-e: Hide menu
	-- C-k: Toggle signature help (if signature.enabled = true)
	--
	-- See :h blink-cmp-config-keymap for defining your own keymap
	keymap = { preset = 'enter' },

	appearance = {
		-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- Adjusts spacing to ensure icons are aligned
		nerd_font_variant = 'mono'
	},

	-- (Default) Only show the documentation popup when manually triggered
	completion = { 
		ghost_text = { enabled = true },
		documentation = { auto_show = true },
		menu = {
			draw = {
				components = {
					kind_icon = {
						text = function(ctx)
						local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
						return kind_icon
					end,
					-- (optional) use highlights from mini.icons
					highlight = function(ctx)
						local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
						return hl
					end,
					},
					kind = {
						-- (optional) use highlights from mini.icons
						highlight = function(ctx)
							local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
							return hl
						end,
					}
				}
			}
		}
	},

	-- Default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, due to `opts_extend`
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},

	-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
	-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
	-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
	--
	-- See the fuzzy documentation for more information
	fuzzy = { implementation = "prefer_rust_with_warning" }
})
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
