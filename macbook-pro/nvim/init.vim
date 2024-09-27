syntax enable

set clipboard=unnamedplus

" colorscheme catppuccin-macchiato
" colorscheme sonokai
colorscheme monokai-pro

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
nnoremap <leader>t <cmd>ToggleTerm<cr>
tnoremap <Esc> <C-\><C-n>

lua require ('plugins')
lua require ('init')

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

