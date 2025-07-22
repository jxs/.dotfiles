return {
  {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    commit = 'b4da76be54691e854d3e0e02c36b0245f945c2c7',
    cmd = "Telescope",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
      { "<leader>f", "<cmd>Telescope git_files<cr>" },
      { "<leader>e", "<cmd>Telescope file_browser path=%:p:h <cr>", desc = "Browse buffer cwd" },
      { "<leader>b", "<cmd>Telescope buffers<cr>",                  desc = "Switch buffer" },
      { "gD",        "<cmd>Telescope lsp_definitions<cr>",          desc = "Lsp type definitions" },
      { "gd",        "<cmd>Telescope lsp_implementations<cr>",      desc = "Lsp type lsp_implementations" },
      { "gR",        "<cmd>Telescope lsp_references<cr>",           desc = "Lsp type lsp_references" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local themes = require("jxs/plugins/telescope/themes")

      telescope.setup({
        defaults = themes.get_ivy_minimal({
          vimgrep_arguments = {
            'rg',
            '--no-heading',
            '--line-number',
            '--column',
            '--case-sensitive',
            '--fixed-strings'
          },
          sorting_strategy = "descending",
          dynamic_preview_title = true,
          results_title = false,
          prompt_title = false,
          layout_config = {
            prompt_position = "bottom",
          },
          path_display = {
            filename_first = true
          },
          mappings = {
            i = {
              ["<esc>"] = actions.close,
            },
          },
        }),
        pickers = {
          git_files = {
            prompt_title = false,
            results_title = false,
            show_untracked = true,
          },
          buffers = {
            prompt_prefix = 'Buffer: ',
            prompt_title = false,
            sort_lastused = true,
            sort_mru = true,
          },
          lsp_references = {
            prompt_title = false,
            results_title = false,
            fname_width = 60,
          },
        },
        extensions = {
          file_browser = {
            disable_devicons = true,
            prompt_title = false,
            git_status = false,
            display_stat = false,
            select_buffer = true,
            preview = {
              ls_short = true,
            },

          }
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
    end,
  },
}
