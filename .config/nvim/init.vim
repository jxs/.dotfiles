" Plugs
" ====================================================================
call plug#begin('~/.config/nvim/plugs/')

Plug 'editorconfig/editorconfig-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': ['rust']}
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
" Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'chaoren/vim-wordmotion'
Plug 'mattn/webapi-vim'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-smooth-scroll'

call plug#end()
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

"share clipboard with OS
set clipboard=unnamed
set termguicolors
set title
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

" Theme
" ====================================================================
colorscheme palenight
set noshowmode
let g:lightline = {'colorscheme': 'palenight',}
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE

" Key mappings
" ====================================================================
let mapleader = "\<C-x>"
nnoremap <silent><leader>u :UndotreeToggle<CR><C-w>h
" nmap  <Leader>w  <Plug>(easymotion-s)
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>f :GFiles -c --others --exclude-standard<CR>
nnoremap <silent> <leader>e :Files<CR>
nnoremap <silent> <leader>c :bd<CR>
nnoremap <silent> <leader>l :Rgz<CR>
nnoremap <silent> <Esc><Esc> :noh<CR><Esc>
inoremap <silent><expr><M-Tab> exists("g:coc_enabled") ? coc#refresh() : "\<C-n>"
imap <C-w> <Esc>ciw
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 20, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 20, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 20, 4)<CR>

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
