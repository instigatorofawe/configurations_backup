syntax enable

set clipboard=unnamedplus

colorscheme catppuccin-macchiato
" colorscheme sonokai

set cursorline
set colorcolumn=120
set textwidth=120
set ruler

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set number relativenumber
set showcmd

filetype indent on

set wildmenu
set lazyredraw
set showmatch

set incsearch
set hlsearch

nnoremap j gj
nnoremap k gk

hi Normal ctermbg=none

nnoremap <leader>v <cmd>CHADopen<cr>

lua require ('plugins')
lua require ('init')

