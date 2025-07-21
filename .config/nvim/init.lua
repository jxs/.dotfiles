-- Global settings
-- ==================================================================
vim.opt.autoread = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes" -- keep signcolumn on by default
vim.opt.foldenable = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('state') .. '/undo'
vim.opt.clipboard = 'unnamedplus'        -- Share clipboard with OS
vim.opt.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.swapfile = false
vim.opt.jumpoptions = "stack"
vim.opt.showmatch = true
vim.opt.matchpairs:append('<:>')
vim.opt.autochdir = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 300

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
vim.g.mapleader = ','

vim.keymap.set('n', '<esc><esc>', ':noh<cr>')
vim.keymap.set('n', '<PageUp>', '<nop>')
vim.keymap.set('n', '<PageDown>', '<nop>')
vim.keymap.set('n', '\'', '/')
vim.keymap.set('n', '<leader>c', ':bd<cr>')

-- Load plugins using lazy.nvim
-- ==================================================================
require('jxs/lazy')

-- Autocommands
-- ==================================================================
vim.cmd [[ autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]]

-- 2 spaces default for yaml and lua
vim.cmd [[ autocmd FileType yaml,lua,typescriptreact,typescript setlocal ts=2 sts=2 sw=2 expandtab ]]

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- Disable semantic tokens for all LSPs
    client.server_capabilities.semanticTokensProvider = nil

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local nmap = function(keys, func)
      vim.keymap.set('n', keys, func, { buffer = bufnr })
    end

    nmap('gr', vim.lsp.buf.rename)
    nmap('ga', vim.lsp.buf.code_action)
    nmap('K', vim.lsp.buf.hover)

    -- create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('LspFormat.' .. bufnr, {}),
      buffer = bufnr,
      command = 'Format',
    })
    --  show diagnostics floating window
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        vim.diagnostic.open_float(nil, {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        })
      end
    })
    if client.server_capabilities.inlayHintProvider then
      vim.keymap.set('n', 'gh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { noremap = true, silent = true, buffer = bufnr, desc = '[lsp] toggle inlay hints' })
    end
  end,
})
