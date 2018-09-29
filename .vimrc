set tabstop=2       " The width of a TAB is set to 2
set shiftwidth=2    " Indents will have a width of 2
set softtabstop=2   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces

set nu
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'StanAngeloff/php.vim'
Plug 'tpope/vim-eunuch'
Plug 'scrooloose/syntastic'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'

call plug#end()

set laststatus=2
set noshowmode
set ttimeoutlen=0 " Remove delay on <Esc>

let mapleader=" "

nnoremap <silent> <A-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :tabprevious<CR>
nnoremap <silent> <C-t> :tabnew<CR>

nnoremap <Leader>j :GFiles<CR>
nnoremap <Leader>J :Files<CR>

