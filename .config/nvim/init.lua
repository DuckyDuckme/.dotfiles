vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.shiftwidth = 4
vim.opt.showmatch = true
vim.opt.softtabstop = 4
vim.opt.cursorline = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.scrolloff = 8  -- 'so' option (scroll offset)
vim.opt.undofile = true     -- undo history survives closing the file
vim.opt.expandtab = true    -- Tab inserts spaces, so no mixed tabs/spaces
vim.opt.splitright = true   -- :vsplit opens to the right
vim.opt.splitbelow = true   -- :split opens below
vim.opt.breakindent = true  -- wrapped lines keep their indentation
vim.opt.linebreak = true    -- wrap at word boundaries, not mid-word
vim.opt.confirm = true      -- :q on an unsaved buffer asks instead of erroring

-- maps the (local)leader (usually the backslash \) to be just the spacebar
vim.g.maplocalleader = ' '
vim.g.mapleader = ' '

vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('n', '<Tab>', '<Cmd>noh<CR>')
vim.keymap.set('n', '0', '^')

-- associate .sage files with .py -- unnecessary if using tree-sitter
--vim.api.nvim_command('autocmd BufRead,BufNewFile *.sage set filetype=python')


-- got this from Claude, not sure what it does lol
-- spellcheck prose (]s / [s jump, z= suggests, zg adds a word); hide LaTeX markup in tex
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'tex', 'gitcommit', 'markdown' },
    callback = function()
        vim.opt_local.spell = true
        if vim.bo.filetype == 'tex' then
            -- this makes \alpha display as an actual alpha, not sure if i like this
            vim.opt_local.conceallevel = 2
        end
    end,
})

-- briefly highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.hl.on_yank() end,
})

---- a little sth from stackoverflow to open the file at last position --
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = {"*"},
    callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.cmd([[normal! g'"]])
        end
    end
})


--if vim.fn.empty(vim.fn.globalpath(vim.o.runtimepath, 'autoload/plug.vim')) == 0 then
    -- for vim plug local vim = vim
    local Plug = vim.fn['plug#']

    vim.call('plug#begin')

    -- themes
    Plug('catppuccin/nvim')
    --Plug('morhetz/gruvbox')
    --Plug('folke/tokyonight.nvim')
    --Plug('EdenEast/nightfox.nvim')
    --Plug('mhartington/oceanic-next')
    --Plug('arzg/vim-colors-xcode')
    
    -- tex support
    Plug('lervag/vimtex')
    -- for code completion
    Plug('saghen/blink.cmp', { ['tag'] = 'v1.*' })

    -- linting
    --Plug('dense-analysis/ale')

    -- telescope
    -- plenary is a dependency of telescope
    Plug('nvim-lua/plenary.nvim')
    Plug('nvim-telescope/telescope.nvim', { ['tag'] = 'v0.2.*' })
    -- optional deps of telescope
    Plug('nvim-treesitter/nvim-treesitter')
    Plug('nvim-tree/nvim-web-devicons')

    vim.call('plug#end')	
--end

-- vim.cmd('silent! colorscheme OceanicNext')
require('catppuccin').setup({ transparent_background = true })
vim.cmd('silent! colorscheme catppuccin')
-- to set the transparent background
-- vim.api.nvim_set_hl(0, "Normal", {})
-- vim.api.nvim_set_hl(0, "LineNr", {})
-- vim.api.nvim_set_hl(0, "SignColumn", {})
-- vim.api.nvim_set_hl(0, "EndOfBuffer", {})


----------- vimtex config ----------
vim.g.vimtex_view_general_viewer = 'okular'
--vim.g.vimtex_view_method = 'evince'
vim.g.vimtex_view_general_options = [[--synctex-forward @line:@col:@file]]
vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]

-- for ignored warnings
vim.g.vimtex_quickfix_ignore_filters = {
    'Overfull', 'Underfull', 'hyperref'
}

-- latexmk configuration
vim.g.vimtex_compiler_latexmk = {
    build_dir = "",		  -- PDF in project root
    aux_dir = "latexmk_build",    -- everything else in latexmk_build/
}
-------- end of vimtex config -------

----------- lsp config --------------
vim.lsp.config('texlab', {
    -- change this to correct path
    cmd = { vim.fn.expand('~/programming/builds/lsp/texlab/target/release/texlab') },
    filetypes = { 'tex', 'plaintex', 'bib' },
    root_markers = { '.latexmkrc', '.git' },
})

vim.lsp.config('sagelsp', {
  cmd = { vim.fn.expand('~/.local/share/mamba/envs/sage-dev/bin/sagelsp') },
  filetypes = { 'sage' },
})

vim.lsp.enable({'sagelsp', 'texlab'})

----------- end of lsp config ---------

----------- blink.cmp config ----------
local ok, blink = pcall(require, 'blink.cmp')
if ok then
    blink.setup({
        keymap = {
            preset = 'enter',  -- Enter accepts, C-space opens, C-e closes
            ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        },
        completion = { list = { selection = { preselect = false } } },
        sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
    })
end
----------- end of blink.cmp config ----

----------- treesitter config ----------
local langs = { 'rust', 'python' }
require('nvim-treesitter').install(langs)

vim.api.nvim_create_autocmd('FileType', {
    -- we can't put sage in langs because then 
    -- treesitter would try to install it but no such thing exists
    -- so we need to unpack the langs array (equivallent of *[a,b,c] 
    -- in python
    pattern = { 'sage', unpack(langs) },
    callback = function() vim.treesitter.start() end,
})
vim.treesitter.language.register('python', 'sage')
-- local ts_ok, ts = pcall(require, 'nvim-treesitter')
-- if ts_ok then
--     -- parsers are compiled on first install (needs tree-sitter CLI and gcc)
--     ts.install({ 'bash', 'toml', 'yaml', 'python', 'rust' })
--
--     vim.api.nvim_create_autocmd('FileType', {
--         pattern = { 'sh', 'bash', 'toml', 'yaml', 'python', 'rust' },
--         callback = function() vim.treesitter.start() end,
--     })
--
--     -- .sage files use the python parser
--     vim.treesitter.language.register('python', 'sage')
-- end
------------ end of treesitter config ---

----------- telescope config ----------
require("telescope").setup()

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
