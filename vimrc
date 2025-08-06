" display line numbers on the left
set number
set relativenumber
set ignorecase
set smartcase
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

" maps <tab> to clear the search pattern
map <tab> :noh<cr>

" map 0 to first non-blank character
map 0 ^

" this automates installation of vim-plug
" let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
" if empty(glob(data_dir . '/autoload/plug.vim'))
  " silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  " autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

" if it is installed
if ! empty(globpath(&rtp, 'autoload/plug.vim'))
    " start the vim.plug config
    call plug#begin()

    " sth the Rust website recommended me
    filetype plugin indent on

    " rust lang support
    " Plug 'rust-lang/rust.vim'

    " gruvbox theme
    Plug 'morhetz/gruvbox'

    " tex support
    Plug 'lervag/vimtex'
    call plug#end()
endif

set background=dark
let g:gruvbox_transparent_bg = 1 " to make background transparent
autocmd VimEnter * hi Normal ctermbg=none
silent! colorscheme gruvbox

" that's to set the pdf viewer of latex to zathura
"let g:vimtex_view_method=‘zathura’
