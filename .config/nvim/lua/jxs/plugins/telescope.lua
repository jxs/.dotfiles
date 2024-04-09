return {
  {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
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
      -- { "<leader>l", function() require("telescope.builtin").live_grep() end },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local themes = require("telescope.themes")
      local strings = require("plenary.strings")
      local utils = require("telescope.utils")

      -- Display paths with basename first and path after
      -- Example:
      --   filename.txt  some/dir
      local format_path_display = function(_, filename)
        local tail = utils.path_tail(filename)
        local path = strings.truncate(filename, #filename - #tail, "")

        return string.format("%s\t\t%s", tail, utils.transform_path({ path_display = { "truncate" } }, path))
      end


      telescope.setup({
        defaults = themes.get_ivy({
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
          borderchars = {
            prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
            preview = { "─", " ", " ", " ", "─", " ", " ", " " },
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
            path_display = format_path_display
          },
          buffers = {
            prompt_prefix = 'Buffer: ',
            prompt_title = false,
            path_display = format_path_display,
            sort_lastused = true,
            sort_mru = true,
            previewer = false,
          }
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
        }
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "TelescopeResults",
        callback = function(ctx)
          vim.api.nvim_buf_call(ctx.buf, function()
            vim.fn.matchadd("TelescopeParent", "\t\t.*$")
            vim.api.nvim_set_hl(0, "TelescopeParent", { link = "TelescopeResultsComment" })
          end)
        end,
      })

      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
    end,
  },
}
