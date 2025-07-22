local themes = require("telescope.themes")
local strategies = require("telescope.pickers.layout_strategies")

local M = {}

local patch_horizontal_layout = function(opts)
  if opts.orientation == "top" then
    strategies.horizontal_fused = function(picker, max_columns, max_lines, layout_config)
      local layout = strategies.horizontal(picker, max_columns, max_lines, layout_config)

      if not layout.preview then
        return vim.tbl_deep_extend("force", layout, {
          prompt = {
            line = layout.prompt.line + 2,
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
          },
          results = {
            title = false,
            line = layout.results.line + 1,
            borderchars = { "─", "│", "─", "│", "├", "┤", "╯", "╰" }
          },
        })
      end

      return vim.tbl_deep_extend("force", layout, {
        preview_width = 1,
        prompt = {
          line = layout.prompt.line + 2,
          width = layout.prompt.width + 1,
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
        },
        results = {
          title = false,
          line = layout.results.line + 1,
          width = layout.results.width + 1,
          borderchars = { "─", "│", "─", "│", "├", "┤", "┴", "╰" }
        },
        preview = {
          line = layout.preview.line + 2,
          height = layout.preview.height - 1,
          borderchars = { "─", "│", "─", "│", "┬", "╮", "╯", "┴" }
        },
      })
    end
  else
    strategies.horizontal_fused = function(picker, max_columns, max_lines, layout_config)
      local layout = strategies.horizontal(picker, max_columns, max_lines, layout_config)

      if not layout.preview then
        return vim.tbl_deep_extend("force", layout, {
          prompt = {
            line = layout.prompt.line + 1,
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
          },
          results = {
            title = layout.prompt.title,
            height = layout.results.height + 1,
            line = layout.results.line + 1,
            borderchars = { "─", "│", "─", "│", "╭", "╮", "┤", "├" }
          },
        })
      end

      return vim.tbl_deep_extend("force", layout, {
        preview_width = 0.5,
        prompt = {
          line = layout.prompt.line + 1,
          width = layout.prompt.width + 1,
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
        },
        results = {
          title = layout.prompt.title,
          height = layout.results.height + 1,
          line = layout.results.line + 1,
          width = layout.results.width + 1,
          borderchars = { "─", "│", "─", "│", "╭", "┬", "┤", "├" }
        },
        preview = {
          line = layout.preview.line + 1,
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "┴" }
        },
      })
    end
  end
end

M.get_ivy_minimal = function(opts)
  opts = opts or {}

  patch_horizontal_layout({ orientation = opts.layout_config and opts.layout_config.prompt_position or "top" })

  local theme_opts = {
    theme = "ivy_minimal",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal_fused",
    layout_config = {
      prompt_position = "top",
      height = 0.4,
      anchor = "S",
      width = function(_, max_columns, _)
        return max_columns
      end,
    },
    border = true,
  }

  if opts.layout_config and opts.layout_config.prompt_position == "bottom" then
    theme_opts.sorting_strategy = "descending"
  end

  return vim.tbl_deep_extend("force", theme_opts, opts)
end

M.get_dropdown = function(opts)
  return themes.get_dropdown(opts)
end

return M

