-- nvim_lsp object
local nvim_lsp = require'lspconfig'
local util = require'lspconfig/util'

nvim_lsp.rust_analyzer.setup({
    cmd = {"rust-analyzer"};
    root_dir = util.root_pattern("Cargo.toml", "rust-project.json");
})
