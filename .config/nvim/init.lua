vim.opt.compatible = false  -- It's typically unnecessary as Neovim is already nocompatible
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.shiftwidth = 4
vim.opt.ruler = true
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.softtabstop = 4
vim.opt.mouse = 'a'
vim.opt.cursorline = true
vim.opt.ttyfast = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.scrolloff = 8  -- 'so' option (scroll offset)

-- maps the (local)leader (usually the backslash \) to be just the spacebar
vim.g.maplocalleader = ' '
vim.g.mapleader = ' '

vim.api.nvim_set_keymap('i', 'kj', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<tab>', ':noh<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '0', '^', { noremap = true, silent = true })

-- associate .sage files with .py
vim.api.nvim_command('autocmd BufRead,BufNewFile *.sage set filetype=python')

---- a little sth from stackoverflow to open the file at last position --
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = {"*"},
    callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.api.nvim_exec("normal! g'\"",false)
        end
    end
})


--if vim.fn.empty(vim.fn.globalpath(vim.o.runtimepath, 'autoload/plug.vim')) == 0 then
    -- for vim plug local vim = vim
    local Plug = vim.fn['plug#']

    vim.call('plug#begin')

    -- themes
    Plug('catppuccin/nvim')
    Plug('morhetz/gruvbox')
    Plug('catppuccin/nvim')
    Plug('folke/tokyonight.nvim')
    Plug('EdenEast/nightfox.nvim')
    Plug('mhartington/oceanic-next')
    Plug('arzg/vim-colors-xcode')
    -- tex support
    Plug('lervag/vimtex')
    -- for commenting out
    --Plug('preservim/nerdcommenter')
    -- for code completion
    Plug('neoclide/coc.nvim', { ['branch'] = 'release' })
    -- linting
    --Plug('dense-analysis/ale')

    -- telescope
    -- plenary is a dependency of telescope
    Plug('nvim-lua/plenary.nvim')
    Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.8' })
    -- optional deps of telescope
    Plug('nvim-treesitter/nvim-treesitter')
    Plug('nvim-tree/nvim-web-devicons')

    vim.call('plug#end')	
--end

--vim.cmd('silent! colorscheme OceanicNext')
vim.cmd('silent! colorscheme catppuccin')
vim.g.termguicolors=true


-- to set the transparent background
vim.api.nvim_set_hl(0, "Normal", {})
vim.api.nvim_set_hl(0, "LineNr", {})
vim.api.nvim_set_hl(0, "SignColumn", {})
vim.api.nvim_set_hl(0, "EndOfBuffer", {})


----------- vimtex config ----------
vim.g.vimtex_view_general_viewer = 'evince'
--vim.g.vimtex_view_method = 'evince'
--vim.g.vimtex_view_general_options = [[--synctex-forward @line:@col:@file]]
--vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
vim.g.tex_flavor = "latex"

-- for ignored warnings
vim.g.vimtex_quickfix_ignore_filters = {
    'Overfull', 'Underfull', 'hyperref'
}
-------- end of vimtex config -------

    
------------- coc config ----------------
-- i found this at coc github
vim.api.nvim_command('autocmd FileType json syntax match Comment +//.*$+')
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)


----------- telescope config ----------
require("telescope").setup()
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })

