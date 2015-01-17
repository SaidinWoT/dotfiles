" Pathogen
filetype plugin indent on | syntax on
set runtimepath+=~/.vim/vim-addon-manager
call vam#ActivateAddons(["vim-go", "monokai", "commentary", "surround", "repeat"])

" general
let g:mapleader = ","

" monokai
colo monokai

" tab fixing
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

" make searching fun!
set ignorecase
set smartcase
set incsearch
set hlsearch
set gdefault
nnoremap <leader>l :nohlsearch<CR>
nnoremap / /\v
vnoremap / /\v

" wrapping
set wrap
set textwidth=79
set formatoptions=qrn1

" backspacing
set backspace=indent,eol,start

" nice scrolling
set scrolloff=4
set sidescrolloff=6

" statusline fun
set ruler
set laststatus=2

" folding
set foldmethod=marker

" sudo magic
cmap w!! %!sudo tee > /dev/null %

" mappings
inoremap jk <ESC>
nnoremap j gj
nnoremap k gk
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" make arrow keys useful
nnoremap <Left>  <C-w>h
nnoremap <Down>  <C-w>j
nnoremap <Up>    <C-w>k
nnoremap <Right> <C-w>l
vnoremap <Left>  <gv
vnoremap <Right> >gv

" meta
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

function! s:mks()
    execute "mksession! ." . system("basename $(pwd)" . ".vim")
    wqa
endfunction

nnoremap <leader>wq :<C-U>call <SID>mks()<CR>

let g:go_fmt_command = "goimports"

highlight Error term=reverse ctermbg=9
highlight Golang term=reverse ctermfg=15 ctermbg=81
" function! s:AuGolang()
"     if !exists("g:au_gofmt_loaded")
"         let g:au_gofmt_loaded = 1
"         augroup golang
"             autocmd BufWritePre,FileWritePre <buffer> Fmt
"         augroup END
"     endif
" endfunction

" if !exists("g:au_gofmt_loading")
"     let g:au_gofmt_loading = 1
"     augroup golang
"         autocmd FileType go call s:AuGolang()
"     augroup END
" endif
