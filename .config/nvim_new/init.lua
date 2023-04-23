-- Global settings
-- ==================================================================
vim.opt.autoread = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.foldenable = false
vim.opt.autochdir = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('state') .. '/undo'
vim.opt.shortmess:append({ c = true }) -- Avoid showing message extra message when using completion
vim.opt.clipboard = 'unnamedplus'      -- Share clipboard with OS
vim.opt.termguicolors = true
vim.opt.title = true

-- Indentation
-- ==================================================================
vim.opt.expandtab = true  -- replace <Tab> with spaces
vim.opt.shiftround = true -- round indent to multiple of 'shiftwidth' (for << and >>)
vim.opt.shiftwidth = 4    -- indent size for << and >>
vim.opt.tabstop = 4       -- number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = 4   -- remove <Tab> symbols as it was spaces

-- Search
-- ==================================================================
vim.opt.ignorecase = true
vim.opt.smartcase = true -- override the 'ignorecase' when there is uppercase letters
vim.opt.gdefault = true  -- when on, the :substitute flag 'g' is default on

-- Key mappings
-- ==================================================================
vim.g.mapleader = '\\,'

vim.keymap.set('n', '<esc><esc>', ':noh<cr>')
vim.keymap.set('n', '<PageUp>', '<nop>')
vim.keymap.set('n', '<PageDown>', '<nop>')

-- Load plugins using lazy.nvim
-- ==================================================================
require('jxs/lazy')

-- Autocommands
-- ==================================================================
vim.cmd [[ autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]]

-- 2 spaces default for yaml
vim.cmd [[ autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab ]]
