local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

return {
  {
    'windwp/nvim-autopairs',
    lazy = true,
    config = true
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', -- completion for LSP
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',   -- completion for buffer text
      'hrsh7th/cmp-cmdline',  -- completion for command line
      'hrsh7th/cmp-path',     -- completion for fylesystem paths
      'hrsh7th/cmp-vsnip',    -- completion for vim-vsnip
      'hrsh7th/vim-vsnip'     -- snippet plugin
    },
    event = 'InsertEnter',
    config = function()
      local cmp = require('cmp')
      local autopairs_cmp = require('nvim-autopairs.completion.cmp')

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
          ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
          ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
          }),
          ['<Tab>'] = function(core, fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.fn['vsnip#jumpable'](1) > 0 then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-jump-next)', true, false, true))
            elseif has_words_before() then
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
      cmp.event:on('confirm_done', autopairs_cmp.on_confirm_done())
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

      vim.cmd [[ hi CmpItemMenuDefault guifg=#4c566a ]]
    end
  }
}
