" display line numbers on the left
set number
set smartcase
set ignorecase
set shiftwidth=4
set ruler

" use F11 to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" keep the same indent as you are on
set autoindent

" highlights the search
set hlsearch

syntax enable

" enable use of mouse for all modes
if has('mouse')
    set mouse=a
endif

" maps 'jh' to escape
inoremap jk <Esc>
