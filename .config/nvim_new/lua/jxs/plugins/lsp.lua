return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'folke/neodev.nvim', config = true },
      { 'j-hui/fidget.nvim', config = true },
    },
    opts = {
      -- LSP servers to automatically install and their configs
      -- if config is a function the default handler will be override by this function
      -- see :h mason-lspconfig-automatic-server-setup
      servers = {
        -- LuaLS options
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },

        -- BashLS options
        bashls = {},

        -- Use rust-tools to setup rust-analyzer
        rust_analyzer = function()
          require('rust-tools')
        end
      },
      -- vim.diagnostic options
      diagnostics = {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = {
          spacing = 4,
          source = 'always',
          prefix = '∎',
        },
        float = {
          border = 'rounded',
          source = 'always',
          header = '',
          scope = 'cursor',
          wrap = true,
          max_width = 80,
        },
      },
      handlers = {
        ["textDocument/signatureHelp"] = {
          vim.lsp.handlers.signatureHelp, { border = 'rounded' }
        },
        ["textDocument/hover"]         = {
          vim.lsp.handlers.hover, { border = 'rounded' }
        }
      }
    },
    config = function(_, opts)
      local mason = require('mason-lspconfig')

      -- setup LSP capabilities
      -- cmp-nvim-lsp supports additional completion capabilities, so broadcast that to servers
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- configure diagnostics
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      -- configure handlers
      for handler_key, handler_opts in pairs(opts.handlers) do
        vim.lsp.handlers[handler_key] = vim.lsp.with(unpack(handler_opts))
      end

      --
      local setup_handlers = {
        function(server_name)
          local server_opts = vim.tbl_deep_extend("force", {
            capabilities = capabilities
          }, opts.servers[server_name] or {})

          require('lspconfig')[server_name].setup(server_opts)
        end,
      }

      for server, server_opts in pairs(opts.servers) do
        if type(server_opts) == 'function' then
          setup_handlers[server] = server_opts
        end
      end

      mason.setup({
        ensure_installed = vim.tbl_keys(opts.servers)
      })

      mason.setup_handlers(setup_handlers)

    end
  },
  {
    'simrat39/rust-tools.nvim',
    lazy = true, -- rust-tools will be loaded by mason-lspconfig
    opts = {
      -- rust-tools options
      tools = {
        inlay_hints = {
          show_parameter_hints = false,
          only_current_line = true,
          highlight = "LineNr"
        }
      },
      -- lspconfig options
      server = {
        settings = {
          ["rust-analyzer"] = { cargo = { allFeatures = true } }
        }
      }
    }
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    opts = {
      ui = {
        border = "rounded"
      }
    }
  }
}
