" display line numbers on the left
set number
set relativenumber
set smartcase
set ignorecase
set shiftwidth=4
set ruler
set encoding=utf8

" use F11 to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" keep the same indent as you are on
set autoindent

" set 7 lines to the cursor - when moving vertically
set so=7

" highlights the search
set hlsearch

" :W to write with root permissions
command! W execute 'w !doas tee % > /dev/null' <bar> edit!
" or for sudo
" command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

syntax enable

" enable use of mouse for all modes
if has('mouse')
    set mouse=a
endif

" maps 'kj' to escape
inoremap kj <Esc>

" map 0 to first non-blank character
map 0 ^

" start the vim.plug config
call plug#begin()

" sth the Rust website recommended me
syntax enable
filetype plugin indent on

" rust lang support
Plug 'rust-lang/rust.vim'

" gruvbox theme
Plug 'morhetz/gruvbox'

" tex support
Plug 'lervag/vimtex'
call plug#end()

set background=dark
colorscheme gruvbox
