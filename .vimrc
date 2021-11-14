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

" return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 & line("'\"") <= line("$") | exe "normal! g'\"" | endif

" :W to write with root permissions
command! W execute 'w !doas tee % > /dev/null' <bar> edit!
" or for sudo
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

syntax enable

" enable use of mouse for all modes
if has('mouse')
    set mouse=a
endif

" maps 'jk' to escape
inoremap jk <Esc>

" map 0 to first non-blank character
map 0 ^

" move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
nmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
nmap <M-j> :m'<-2<cr>`<my`>mzgv`yo`z
