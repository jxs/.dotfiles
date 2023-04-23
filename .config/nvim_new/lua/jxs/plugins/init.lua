return {
  {
    'chaoren/vim-wordmotion',
    event = { "BufReadPost", "BufNewFile" }
  },
  {
    'tpope/vim-commentary',
    event = { "BufReadPost", "BufNewFile" }
  },
  {
    'terryma/vim-smooth-scroll',
    keys = {
      { '<c-u>', '<cmd>call smooth_scroll#up(&scroll, 20, 2)<cr>'  },
      { '<c-d>', '<cmd>call smooth_scroll#down(&scroll, 20, 2)<cr>'  },
      { '<c-b>', '<cmd>call smooth_scroll#up(&scroll*2, 20, 4)<cr>'  },
      { '<c-f>', '<cmd>call smooth_scroll#down(&scroll*2, 20, 4)<cr>'  },
    }
  },
  {
    'mbbill/undotree',
    keys = {
      { '<leader>u', '<cmd>UndotreeToggle<CR><C-w>h' },
    }
  },
  {
    'jxs/palenight.vim',
    priority = 1000, -- load this plugin first
    init = function()
      vim.g.palenight_terminal_italics = 1
      vim.g.palenight_color_overrides = {
        blue = { gui = '#66a1ff', cterm = '39', cterm16 = '4' },
        cyan = { gui = '#01b1a4', cterm = '38', cterm16 = '6' },
        black = { gui = '#171819', cterm = '235', cterm16 = '0' }
      }
    end,
    config = function()
      vim.cmd.colorscheme 'palenight'
    end
  },
  {
    'itchyny/lightline.vim',
    init = function()
      vim.g.lightline = {
        colorscheme = 'palenight',
        active = {
          left = {
            { 'mode', 'paste' },
            { 'readonly', 'filename', 'filetype', 'modified' }
          },
          right = {
            { 'lineinfo' },
            { 'percent' },
            { 'fileencoding', 'fileformat' }
          },
        },
        component_function = {
          gitbranch = 'gitbranch#name'
        },
      }
    end
  },
}
