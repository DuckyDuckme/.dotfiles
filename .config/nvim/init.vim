set nocompatible
set number
set relativenumber
set ignorecase
set smartcase
set shiftwidth=4
set ruler
set showmatch
set hlsearch
set softtabstop=4
set mouse=a
set cursorline
set ttyfast
set clipboard=unnamedplus

" set 7 lines to the cursor - when moving vertically
set so=7

" :W to write with root permissions
command! W execute 'w !doas tee % > /dev/null' <bar> edit!
" or for sudo
" command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" maps 'kj' to escape
inoremap kj <Esc>

" maps <tab> to clear the search pattern
map <tab> :noh<cr>

" map 0 to first non-blank character
map 0 ^

" start the vim.plug config
call plug#begin()
    " gruvbox theme
    Plug 'morhetz/gruvbox'
    " tex support
    Plug 'lervag/vimtex'
    " for commenting out
    Plug 'preservim/nerdcommenter'
call plug#end()

silent! colorscheme gruvbox

" ------ vimtex configuration ---------
" that's to set the pdf viewer of latex to okular
let g:vimtex_view_general_viewer = "okular"

" ------ nerdcommenter config ---------
" default mappings
let g:NERDCreateDefaultMappings = 1
" map (un)commenting to ctrl + /
map <C-/> <plug>NERDCommenterInvert
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
