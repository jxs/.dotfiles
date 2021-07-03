" Plugs
" ====================================================================
call plug#begin('~/.config/nvim/plugs/')

Plug 'editorconfig/editorconfig-vim'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'haorenW1025/completion-nvim'
Plug 'mbbill/undotree'
Plug 'chaoren/vim-wordmotion'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-smooth-scroll'
Plug 'cespare/vim-toml'

call plug#end()
" Theme
" ====================================================================
colorscheme palenight
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'filetype', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'gitbranch', 'fileencoding', 'fileformat'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

" Global Settings
" ====================================================================
set autoread
set number! relativenumber!
set nofoldenable
set autochdir
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set undofile
set undodir=~/.config/nvim/undo/
" Lsp config
lua <<EOF
  local nvim_lsp = require'lspconfig'
  local util = require'lspconfig/util'

  nvim_lsp.rust_analyzer.setup({
    cmd = {"rust-analyzer"};
  })
EOF
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c
" 2 spaces default for yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
let g:completion_enable_auto_popup = 0
let g:completion_chain_complete_list = {
            \ 'default': {
            \   'default': [
            \      {'complete_items': ['lsp', 'snippet']},
            \      {'mode': '<c-n>'},
            \   ],
            \   'string': [
            \      {'complete_items': ['path']},
            \   ],
            \   'comment': [
            \      {'complete_items': ['path']},
            \   ],
            \ },
            \ }
autocmd BufEnter * lua require'completion'.on_attach()

"share clipboard with OS
set clipboard=unnamedplus
set termguicolors
set title
set backspace=indent,eol,start
"fzf config
let g:fzf_layout = { 'down': '30%' }
" Indentation
" ====================================================================
set expandtab     " replace <Tab> with spaces
set tabstop=4     " number of spaces that a <Tab> in the file counts for
set softtabstop=4 " remove <Tab> symbols as it was spaces
set shiftwidth=4  " indent size for << and >>
set shiftround    " round indent to multiple of 'shiftwidth' (for << and >>)

" Search
" ====================================================================
set ignorecase
set smartcase  " override the 'ignorecase' when there is uppercase letters
set gdefault   " when on, the :substitute flag 'g' is default on

" Key mappings
" ====================================================================
let mapleader = "\<C-x>"
nnoremap <silent><leader>u :UndotreeToggle<CR><C-w>h
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>f :GFiles -c --others --exclude-standard<CR>
nnoremap <silent> <leader>e :FZFExplore<CR>
nnoremap <silent> <leader>c :bd<CR>
nnoremap <silent> <leader>l :Rgz<CR>
nnoremap <silent> <Esc><Esc> :noh<CR><Esc>
" inoremap <silent><expr> <M-Tab> completion#trigger_completion()
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ completion#trigger_completion()
nnoremap <silent> gD <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.rename()<CR>
imap <C-BS> <C-W>
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 20, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 20, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 20, 4)<CR>
noremap ' /
noremap <PageUp> <nop>
noremap <PageDown> <nop>
" tnoremap <Esc> <C-\><C-n>
" Autocmd's
" ====================================================================
" clear whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Custom functions
" ===================================================================
" Search pattern across repository files
function! RgFzf(...)
    let input = input('Enter expression: ')
    let git_root = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
    let rg_command = printf("rg --column --line-number --no-heading --color=always --fixed-strings '%s' %s", input, git_root)
    call fzf#vim#grep(rg_command, 1, fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}))
endfunction
command! -bang -nargs=* Rgz call RgFzf(shellescape(<q-args>), {}, <bang>0)

" Search pattern across repository files
function! FzfExplore(...)
    let inpath = substitute(a:1, "'", '', 'g')
    if inpath == "" || matchend(inpath, '/') == strlen(inpath)
        execute "cd" getcwd() . '/' . inpath
        let cwpath = getcwd() . '/'
        call fzf#run(fzf#wrap(fzf#vim#with_preview({'source': 'ls -1ap', 'dir': cwpath, 'sink': 'FZFExplore', 'options': ['--prompt', cwpath]})))
    else
        let file = getcwd() . '/' . inpath
        execute "e" file
    endif
endfunction

command! -nargs=* FZFExplore call FzfExplore(shellescape(<q-args>))
