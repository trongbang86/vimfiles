call dirsettings#Install()

execute pathogen#infect()
syntax on
filetype plugin indent on

" KEY MAPPINGS

" change leader key
let mapleader = ','

noremap <Leader>n <esc>:NERDTreeToggle<CR>
noremap <Leader>c <esc>:CtrlP<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" quickly change to NORMAL mode in interactive mode
inoremap jk <esc>

" shortcuts to edit and source .vimrc file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

noremap <Leader>s <esc>:w<CR>

" SETTINGS
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

set number

set mouse=a

let g:ctrlp_regexp = 1

" Powerline
set laststatus=2 " To fix Vim Powerline not showing in single window
let &t_Co=256 " To fix missing colors in Vim Powerline

" Airline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
 
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
