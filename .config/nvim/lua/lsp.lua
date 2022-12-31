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
  -- A list of parser names, or "all"
  ensure_installed = { 'rust' },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    disable = { "gitcommit" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
