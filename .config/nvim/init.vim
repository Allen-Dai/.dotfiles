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
set clipboard+=unnamedplus
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
Plug 'rcarriga/nvim-notify'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'leoluz/nvim-dap-go'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-telescope/telescope-dap.nvim'

Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'

Plug 'gruvbox-community/gruvbox'
Plug 'EdenEast/nightfox.nvim'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

"git
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
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

"Lsp autocomplete
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

nnoremap <C-h> :wincmd h<cr>
nnoremap <C-j> :wincmd j<cr>
nnoremap <C-k> :wincmd k<cr>
nnoremap <C-l> :wincmd l<cr>

nnoremap <C-a> <Nop>
nnoremap g<C-a> <Nop>
nnoremap <C-x> <Nop>
nnoremap g<C-x> <Nop>

"To disbale 'q' for recording - i dont use it :l
nnoremap q <Nop>
"slice contron-f for my tmux-session script
nnoremap <silent> <C-f> :silent !tmux neww tmux-session<CR>

"Undo
if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif
