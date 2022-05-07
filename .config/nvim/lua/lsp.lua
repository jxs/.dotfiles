local nvim_lsp = require'lspconfig'
local util = require'lspconfig/util'
local cmp = require'cmp'

-- check if we should indent or complete
local check_back_space = function()
    local col = vim.fn.col '.' - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
end

cmp.setup({
    completion = {
        completeopt = 'menu,menuone,noinsert',
        autocomplete = false
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
        ['<Tab>'] = function(core, fallback)
            if vim.fn['vsnip#jumpable'](1) > 0 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-jump-next)', true, false, true))
            elseif vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
            elseif not check_back_space() then
                cmp.mapping.complete()(core, fallback)
            else
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n')
            end
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'buffer' },
    }
})

nvim_lsp.rust_analyzer.setup({
    cmd = {"rust-analyzer"};
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true
            },
        },
    };
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
})

