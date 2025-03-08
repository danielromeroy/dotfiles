set number
set autoindent
set background=dark
set history=500
syntax enable

" prefer spaces over tabs
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" enable mouse control
set mouse=a

" highlight search results
set hlsearch  

" nicer search
set incsearch 

" show matching brackets when text indicator is over them
set showmatch 

" no osund on error
set noerrorbells

filetype plugin on
filetype indent on

" update file on external write
set autoread
au FocusGained,BufEnter * silent! checktime


try
    colorscheme slate
catch
endtry