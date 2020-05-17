local nvim_lsp = require'nvim_lsp'
nvim_lsp.rust_analyzer.setup {
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      completion = {
        addCallArgumentSnippets = false,
        addCallParenthesis = false,
      },
    },
  }
}
