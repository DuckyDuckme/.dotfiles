" My own vim settings, installed as ~/.vimrc.
"
" The basics (line numbers, search, indenting, the kj/Tab/0 mappings) live in
" .config/system/vimrc.local, which is installed by hand as
" /etc/vimrc.local and loaded before this file.

" on machines where it isn't installed system-wide, load it straight from the repo
if !filereadable('/etc/vimrc.local')
    silent! source ~/.dotfiles/.config/system/vimrc.local
endif

" :W writes the file with root permissions
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" plugins, only if vim-plug is installed
if !empty(globpath(&rtp, 'autoload/plug.vim'))
    call plug#begin()

    " gruvbox theme
    Plug 'morhetz/gruvbox'

    " tex support
    Plug 'lervag/vimtex'

    call plug#end()
endif

" transparent background: clear Normal's background after any colorscheme loads
augroup transparent_bg
    autocmd!
    autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
augroup END

set background=dark
silent! colorscheme gruvbox
