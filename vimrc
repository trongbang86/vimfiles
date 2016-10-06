call dirsettings#Install()

execute pathogen#infect()
syntax on
filetype plugin indent on

" KEY MAPPINGS

" change leader key
let mapleader = ','

" NERD Tree
noremap <Leader>n <esc>:NERDTreeToggle<CR>
noremap <Leader>nf <esc>:NERDTreeFind<cr>

noremap <Leader>c <esc>:CtrlP<CR>

" mapping to find words under cursor
" and to open up quick list
nnoremap f* :vimgrep /<C-r><C-w>/gj %<cr> <bar> :cw<cr>

" mapping to toggle search highlight
nnoremap <Leader>hs :set hlsearch!<cr>

" mapping to toggle wrap
nnoremap <Leader>wr :set wrap!<cr>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Shortcut to Select All
noremap <Leader>a <esc>ggvG$

" quickly change to NORMAL mode in interactive mode
inoremap jk <esc>

" shortcuts to edit and source .vimrc file
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" shortcuts to edit tmux config
nnoremap <leader>et :e ~/.tmux.conf<cr>

" shortcuts to edit .bash_profile
nnoremap <leader>eb :e ~/.bash_profile<cr>

" shortcut to save the current document
nnoremap <Leader>s :w<CR>

" shortcut to close the current buffer
nnoremap <Leader>q :q<CR>

" shortcut to move between windows
nnoremap <Leader>w <C-w><C-w>

" shortcut to make the current windows dominantly
nnoremap <Leader>ol <C-w><C-o>

" shortcut to increase width of a window
" when there are 2 vertical splits
nnoremap <Leader>rw :vertical resize +30<cr>

" shortcut to reload all buffers
nnoremap <Leader>rb :bufdo e<cr>

" shortcut to BufOnly
nnoremap <Leader>bo :BufOnly<cr>

" Disabled this C-z because it quits VIM
" while editting
" inoremap <c-z> <esc>u

" put the cursor into a new line
" with blank lines on top and bottom
" and change to insert mode
nnoremap om o<esc>O

" put the cursor above in insert
" mode with blank lines surrounding
nnoremap oa O<esc>o<esc>O

" mapping for Tagbar for listing
" functions and variables
nmap <Leader>T :TagbarToggle<CR>

" buffer last
nnoremap <Leader>bl <c-^>

" turn off diff window
nnoremap <Leader>do :windo diffoff<cr>

" mapping to yank to clipboard
silent! vunmap <C-c>
vnoremap <C-c> "*y
silent! vunmap <C-x>
vnoremap <C-x> "*ygvd
silent! iunmap <C-p>
inoremap <C-p> <C-r>*
silent! nunmap <C-p>
nnoremap <C-p> i<C-r>*<esc>

" Store swap files in fixed location, not current directory.
set dir=~/.vimswap//,/var/tmp//,/tmp//,.

" Defining key maps for copying path
" Convert slashes to backslashes for Windows.
if has('win32')
nmap <leader>cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
nmap <leader>cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

  " This will copy the path in 8.3 short format, for DOS and Windows 9x
  nmap <leader>c8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
  nmap <leader>cs :let @*=expand("%")<CR>
  nmap <leader>cl :let @*=expand("%:p")<CR>
endif

" SETTINGS
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

set ignorecase

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

nnoremap <leader>ft :call SetFileType()<cr>
function! SetFileType()
    let filename= expand("%:t")
    let ext = expand("%:e")    
    echom "FileName:" . filename
    echom "Extension:". ext

    if filename == ".bash_profile"
        let &filetype="sh"
    elseif filename == ".vimrc"
        let &filetype="vim"
    end

    if ext == "js"
        let &filetype= "javascript"
    elseif ext == "py"
        let &filetype= "python"
    elseif ext == "java"
        let &filetype= "java"
    elseif ext == "rb"
        let &filetype= "ruby"
    end
endfunction

" REFERENCE:
" http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <silent> <leader>ll :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>qf :call ToggleList("Quickfix List", 'c')<CR>

" END: http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window

function! FileStatus()
    let modified = &modified

    if modified
        echom "Saved: NO"
    else
        echom "Saved: YES"
    end

endfunction

nnoremap <leader>fs :call FileStatus()<cr>
