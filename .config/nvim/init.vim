" Plugs
" ====================================================================
call plug#begin('~/.config/nvim/plugs/')

Plug 'editorconfig/editorconfig-vim'
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lsp'
Plug 'haorenW1025/completion-nvim'
Plug 'mbbill/undotree'
Plug 'chaoren/vim-wordmotion'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-smooth-scroll'

call plug#end()
" Theme
" ====================================================================
colorscheme palenight
set noshowmode
let g:lightline = {'colorscheme': 'palenight',}
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE

" Global Settings
" ====================================================================
set autoread
" checktime checks current file for changes, see https://github.com/neovim/neovim/issues/1936
au FocusGained * :checktime
set number! relativenumber!
set nofoldenable
set autochdir
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set undofile
set undodir=~/.config/nvim/undo/
" Lsp config
luafile ~/.config/nvim/lsp.lua
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c
let g:completion_enable_auto_popup = 0
autocmd BufEnter * lua require'completion'.on_attach()

"share clipboard with OS
set clipboard=unnamedplus
set termguicolors
set title
set backspace=indent,eol,start
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
nnoremap <silent> <leader>e :Files<CR>
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
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
imap <C-BS> <C-W>
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 20, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 20, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 20, 4)<CR>
noremap <PageUp> <nop>
noremap <PageDown> <nop>
" Autocmd's
" ====================================================================
" clear whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Custom functions
" ===================================================================
function! RgFzf(query, spec, fullscreen)
    let git_root = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
    let rg_command = printf("rg --column --line-number --no-heading --color=always  %s %s", a:query, git_root)
    call fzf#vim#grep(rg_command, 1, a:spec, a:fullscreen)
endfunction
command! -bang -nargs=* Rgz call RgFzf(shellescape(<q-args>), {}, <bang>0)
