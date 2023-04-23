return {
  {
    'simrat39/rust-tools.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    ft = { 'rust' },
    opts = {
      -- rust-tools options
      tools = {
        inlay_hints = {
          show_parameter_hints = false,
          only_current_line = true,
          highlight = "LineNr"
        }
      },
      -- LSP options
      server = {
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true
            }
          }
        },
        on_attach = function(client, bufnr)
          -- disable LSP semantic highlighting
          client.server_capabilities.semanticTokensProvider = nil

          -- LSP specific mappings
          local nmap = function(keys, func)
            vim.keymap.set('n', keys, func, { buffer = bufnr })
          end

          nmap('gD', vim.lsp.buf.definition)
          nmap('gd', vim.lsp.buf.implementation)
          nmap('gr', vim.lsp.buf.rename)
          nmap('ga', vim.lsp.buf.code_action)

          -- create a command `:Format` local to the LSP buffer
          vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
          end, { desc = 'Format current buffer with LSP' })

          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
            buffer = bufnr,
            command = 'Format',
          })

          --  show diagnostics floating window
          vim.api.nvim_create_autocmd("CursorHold", {
            buffer = bufnr,
            callback = function()
              vim.diagnostic.open_float(nil, {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
              })
            end
          })
        end
      }
    },
    config = function(_, opts)
      require('rust-tools').setup(opts)

      vim.diagnostic.config({
        signs = true,
        underline = true,
        update_in_insert = true,
        virtual_text = false,
        severity_sort = false,
        float = {
          border = 'rounded',
          source = 'always',
          suffix = ' ',
          prefix = ' ',
          header = '',
          scope = 'cursor',
          wrap = true,
          max_width = 80,
        },
      })
    end
  }
}
