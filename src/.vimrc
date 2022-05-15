set nocompatible              " required
filetype off                  " required

set noerrorbells
" set cursorline
set number relativenumber
set tabstop=4 softtabstop=4
set noswapfile
set nowrap
set undodir=~/.vim/undodir
set undofile
set incsearch
set colorcolumn=80

function! Myhighlight() abort
	" change the colored column set above to lightgrey.
	highlight ColorColumn ctermbg=0 guibg=lightgrey
	"highlight Normal guibg=none
endfunction


" LINK: https://github.com/gmarik/Vundle.vim.git
" set the runtime path to include Vundle and initialize
"  set rtp+=~/.vim/bundle/Vundle.vim
"  call vundle#begin()
"  
"  " alternatively, pass a path where Vundle should install plugins
"  "call vundle#begin('~/some/path/here')
"  
"  " let Vundle manage Vundle, required
"  Plugin 'gmarik/Vundle.vim'
"  
"  " add all your plugins here (note older versions of Vundle
"  " used Bundle instead of Plugin)
"  
"  " ...
"  
"  " All of your Plugins must be added before the following line
"  call vundle#end()            " required
filetype plugin indent on    " required


autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc


syntax on
:colorscheme monokai



let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_liststyle = 3
let g:netrw_winsize = 18
let g:netrw_altv = 1
let g:netrw_list_hide = &wildignore

autocmd ColorScheme monokai call Myhighlight()

highlight CursorLine ctermfg=none ctermbg=none

