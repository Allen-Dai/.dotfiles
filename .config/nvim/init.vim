set nu
set rnu
set nohlsearch
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set nowrap
set noswapfile
set nobackup
set expandtab
set smartindent
set incsearch
set scrolloff=15
set hidden
set autoindent
set signcolumn=yes
set cmdheight=1
set updatetime=50
set shortmess+=c
"set laststatus=0

call plug#begin('~/.config/nvim/plugged')

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-fugitive'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/completion-nvim'
" Plug 'prettier/vim-prettier', {'do': 'npm install'}
" Plug 'roxma/vim-tmux-clipboard'
Plug 'tjdevries/Comment.nvim'

" Auto cmp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

"Tabnine
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
" Luasnip
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'onsails/lspkind-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'nvim-lua/lsp-status.nvim'

Plug 'gruvbox-community/gruvbox'
Plug 'EdenEast/nightfox.nvim'
call plug#end()

lua require 'init'

"Colors"
if (has("termguicolors"))
    set termguicolors
endif
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

"Colorscheme config
set background=dark
"let g:gruvbox_invert_selection = '0'
set t_Co=256
let g:neosolarized_contrast = "high"
let g:neosolarized_termtrans = 1
colorscheme gruvbox
"highlight Normal guibg=#181a1b
highlight Normal guibg=none
highlight SignColumn guibg=none
highlight CursorLineNr guibg=none
"highlight Pmenu guibg=#202225
highlight Pmenu guibg=#36383a
highlight MatchParen guibg=#4C566A
highlight LineNr guibg=none

lua require'nvim-treesitter.configs'.setup{highlight = { enable = true}}

"Telescope
lua require('telescope').load_extension('fzy_native')
nnoremap <C-p> :lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <space>g <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

lua require('nvim-web-devicons').get_icons()

"Lsp autocomplete
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"Tmux stuff
"inoremap <c-h> <ESC>
"autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%:t"))

"Vim window movement keybinds
nnoremap <leader>h :wincmd h<cr>
nnoremap <leader>j :wincmd j<cr>
nnoremap <leader>k :wincmd k<cr>
nnoremap <leader>l :wincmd l<cr>

"Vim comment
lua require('Comment').setup()

" Python Exec
" nnoremap <C-\> :!python3 % <CR>

" Clipboard
set clipboard+=unnamedplus

"
nnoremap <silent> <C-f> :silent !tmux neww tmux-session<CR>

"To disbale 'q' for recording - i dont use it :l
nnoremap q <Nop>

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

nnoremap <C-a> <Nop>
nnoremap g<C-a> <Nop>
nnoremap <C-x> <Nop>
nnoremap g<C-x> <Nop>
