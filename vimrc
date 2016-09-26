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

" Shortcut to Select All
noremap <Leader>a <esc>ggvG$

" quickly change to NORMAL mode in interactive mode
inoremap jk <esc>

" shortcuts to edit and source .vimrc file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

noremap <Leader>s <esc>:w<CR>

" Disabled this C-z because it quits VIM
" while editting
" inoremap <c-z> <esc>u

" put the cursor into a new line
" with blank lines on top and bottom
" and change to insert mode
nnoremap om o<esc>O

" mapping for Tagbar for listing
" functions and variables
nmap <Leader>t :TagbarToggle<CR>

" Defining key maps for copying path
" Convert slashes to backslashes for Windows.
if has('win32')
  nmap ,cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
  nmap ,cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

  " This will copy the path in 8.3 short format, for DOS and Windows 9x
  nmap ,c8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
  nmap ,cs :let @*=expand("%")<CR>
  nmap ,cl :let @*=expand("%:p")<CR>
endif

" SETTINGS
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

set backspace=indent,eol,start

set number

set mouse=a

let g:ctrlp_regexp = 1

set tabstop=4 shiftwidth=4 expandtab

" allow initialising a new buffer without saving the current one
set hidden

" for Gdiff to show side by side 
set diffopt=vertical

" Powerline
set laststatus=2 " To fix Vim Powerline not showing in single window
let &t_Co=256 " To fix missing colors in Vim Powerline

" Airline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 0
 
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

inoremap <c-s> <esc>:wi

nnoremap <Leader>df :call DiffOrig()<CR>

function! DiffOrig()
		if !exists("b:diff_active") && &buftype == "nofile"
				echoerr "E: Cannot diff a scratch buffer"
				return -1
		elseif expand("%") == ""
				echoerr "E: Buffer doesn't exist on disk"
				return -1
		endif

		if !exists("b:diff_active") || b:diff_active == 0
				let b:diff_active = 1
				let l:orig_filetype = &l:filetype

				leftabove vnew
				let t:diff_buffer = bufnr("%")
				set buftype=nofile

				read #
				0delete_
				let &l:filetype = l:orig_filetype

				diffthis
				wincmd p
				diffthis
		else
				diffoff
				execute "bdelete " . t:diff_buffer
				let b:diff_active = 0
		endif
endfunction
