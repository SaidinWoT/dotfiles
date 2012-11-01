" Pathogen
filetype off
call pathogen#infect()
filetype plugin indent on

" general
set nocompatible
let mapleader = ","

" tab fixing
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

" syntax highlighting
syntax on

" make searching fun!
set ignorecase
set smartcase
set incsearch
set hlsearch
set gdefault
nnoremap <leader>l :nohl<CR>
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

" meta
nnoremap <leader>ev :vs $MYVIMRC<CR>
nnoremap <leader>sv :so $MYVIMRC<CR>
