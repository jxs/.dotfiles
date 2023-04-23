-- Install package manager
--  `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require('lazy').setup('jxs/plugins', {
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { 'palenight', "habamax" },
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
  },
  -- performance = {
  --   rtp = {
  --     disabled_plugins = {
  --       "gzip",
  --       "matchit",
  --       "matchparen",
  --       "netrwPlugin",
  --       "tarPlugin",
  --       "tohtml",
  --       "tutor",
  --       "zipPlugin",
  --     },
  --   },
  -- },
})

vim.keymap.set('n', '<leader>z', '<cmd>:Lazy<cr>', { desc = "Plugin Manager" })

