call dirsettings#Install()

execute pathogen#infect()
syntax on
filetype plugin indent on

" check one time after 4s of inactivity in normal mode
set autoread
au CursorHold * checktime
au FileChangedShell * echo "Warning: File changed on disk"

source ~/common_keys.vim

" KEY MAPPINGS

" Fugitive
silent! unmap gd
silent! unmap gs
silent! unmap gc
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit -m '

" NERD Tree
noremap <Leader>n <esc>:NERDTreeToggle<CR>
noremap <Leader>nf <esc>:NERDTreeFind<cr>

noremap <Leader>t2f <esc>:e /Users/bang/documents/temp/t2f.txt<cr>

" CtrlP settings
noremap <Leader>cp <esc>:CtrlP<CR>
let g:ctrlp_show_hidden = 1

" mapping for Tagbar for listing
" functions and variables
nmap <Leader>tb :TagbarToggle<CR>

" Defining key maps for copying path
" Convert slashes to backslashes for Windows.
if has('win32')
    nmap <leader>fs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
    nmap <leader>fl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

    " This will copy the path in 8.3 short format, for DOS and Windows 9x
    nmap <leader>f8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
    nmap <leader>fs :let @*=expand("%")<CR>
    nmap <leader>fl :let @*=expand("%:p")<CR>
endif

" SETTINGS
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

set ignorecase

set backspace=indent,eol,start

set number

set ttymouse=xterm2
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
    " reset filetype
    let &filetype = ''

    let filename= expand("%:t")
    let ext = expand("%:e")    
    " echom "FileName:" . filename
    " echom "Extension:". ext

    if filename == ".bash_profile"
        let &filetype="sh"
    elseif filename == ".vimrc"
        let &filetype="vim"
    end

    if &filetype != ''
        return
    end

    if ext == "js"
        let &filetype= "javascript"
    elseif ext == "py"
        let &filetype= "python"
    elseif ext == "java"
        let &filetype= "java"
    elseif ext == "rb"
        let &filetype= "ruby"
    elseif ext == "md"
        let &filetype= "markdown"
    else
        let &filetype = ext
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

    let filename = expand('%:p')
    echom "Filename:". filename

endfunction

nnoremap <leader>fs :call FileStatus()<cr>

" Set up key mapping for CamelCaseMotion
call camelcasemotion#CreateMotionMappings(';')

source ~/.vimrc_after
