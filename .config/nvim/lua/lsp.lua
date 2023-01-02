require("nvim-autopairs").setup {}
local nvim_lsp = require'lspconfig'
local util = require'lspconfig/util'
local cmp = require'cmp'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local rt = require('rust-tools')
local treesitter = require('nvim-treesitter.configs')

-- check if we should indent or complete
local check_back_space = function()
    local col = vim.fn.col '.' - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
end

local opts = {
    tools = { -- rust-tools options
        inlay_hints = {
            show_parameter_hints = false,
            only_current_line = true,
            highlight = "LineNr",
        },
    },
    server = {
        settings = {
            ["rust-analyzer"] = {
                cargo = {
                    allFeatures = true
                },
            }
        }
    },
}
rt.setup(opts)

cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
        ['<Tab>'] = function(core, fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn['vsnip#jumpable'](1) > 0 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-jump-next)', true, false, true))
            elseif not check_back_space() then
                cmp.mapping.complete()(core, fallback)
            else
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n')
            end
        end,
    },
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'vsnip' },
        { name = 'buffer' },
    }
})
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

treesitter.setup {
  ensure_installed = { 'rust' },

  auto_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    disable = { "gitcommit" },

    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn", -- set to `false` to disable one of the mappings
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
