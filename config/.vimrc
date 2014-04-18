set nocompatible

set background=dark
set encoding=utf-8
set showcmd

syn on

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set backspace=indent,eol,start

autocmd FileType python set autoindent
autocmd FileType mustache set filetype=html
au BufNewFile,BufRead *.as set filetype=java

set hlsearch
set incsearch
set ignorecase
set smartcase

set tags=tags;/

map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

set paste
set ruler
set number

filetype off

filetype plugin indent on

nnoremap<cr> :noh<cr><cr>:<backspace>
