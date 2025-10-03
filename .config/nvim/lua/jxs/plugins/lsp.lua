return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'folke/neodev.nvim',                config = true },
      { 'j-hui/fidget.nvim',                config = true, tag = "legacy" },
    },
    opts = {
      -- LSP servers to automatically install and their configs
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
        -- TOML file settings
        taplo = {
          settings = {
            evenBetterToml = {
              formatter = {
                arrayAutoExpand = false,
                arrayAutoCollapse = false,
                alignComments = false,
              }
            }
          }
        },
      },
      inlay_hints = {
        enabled = true,
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
    },
    config = function(_, opts)
      local mason = require('mason-lspconfig')

      -- setup LSP capabilities
      -- cmp-nvim-lsp supports additional completion capabilities, so broadcast that to servers
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- configure diagnostics
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))


      -- setup LSP servers
      vim.lsp.config("*", { capabilities = capabilities })

      for server_name, server_opts in pairs(opts.servers) do
        vim.lsp.config(server_name, server_opts)
      end

      mason.setup({
        automatic_enable = {
          exclude = { "rust_analyzer" }
        },
        ensure_installed = vim.tbl_keys(opts.servers),
      })
    end
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4',
    ft = 'rust',
    init = function()
      vim.g.rustaceanvim = {
        -- LSP configuration
        server = {
          default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
              cargo = {
                allFeatures = true,
              },
            },
          },
        },
      }
    end
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
