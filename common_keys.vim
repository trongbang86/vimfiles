" change leader key
let mapleader = ','

" mapping to copy into clipboard the current line
" from first non-empty char to last non-empty char
nnoremap vl ^v$h

" mapping for cursorline
" to know where the cursor is
nnoremap wh :set cursorline!<cr>

" toggle ignorecase
nnoremap <leader>ic :set ignorecase!<cr>

" mapping to alter paste mode
nnoremap <leader>p :set paste!<cr>

" mapping to diffthis
nnoremap <leader>dt :windo diffthis<cr>

" mapping to diffoff
nnoremap <leader>do :diffoff<cr>

" mapping to close panes
nnoremap <C-w> :q<cr>

" mapping to set fold method
nnoremap <Leader>fold :setlocal foldmethod=syntax<cr>

" mapping to find words under cursor
" and to open up quick list
nnoremap f* :vimgrep /<C-r><C-w>/gj %<cr> <bar> :cw<cr>

" mapping to find words in memory
" and to open up quick list
nnoremap fm :vimgrep /<C-R>"/gj %<CR> <bar> :cw<CR>

" mapping to find words by user input
" and to open up quick list
nnoremap fs :call SearchVimGrep() <cr>

" mapping to page down/page up
nnoremap ff <C-f>
nnoremap FF <C-b>


" mapping to search
" for the current word under cursor
nnoremap sw /<C-R><C-W><CR>

" mapping to move up and down quicker
noremap <leader>j 7j<cr>
noremap <leader>k 7k<cr>

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
nnoremap <leader>eck :e ~/common_keys.vim<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" shortcuts to diffget and diffput
nnoremap dp :diffput<cr>
nnoremap dg :diffget<cr>

" shortcuts to edit tmux config
nnoremap <leader>et :e ~/.tmux.conf<cr>

" shortcuts to edit .bash_profile
nnoremap <leader>eb :e ~/.bash_profile<cr>

" shortcut to save the current document
noremap <Leader>s :w<CR>
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>

" shortcut to move between windows
nnoremap <Leader>nw <C-w><C-w>
nnoremap <Leader>w= <C-w>=

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

" buffer last
nnoremap <Leader>bl <c-^>

" turn off diff window
nnoremap <Leader>do :windo diffoff<cr>

" mapping to yank to clipboard
silent! vunmap <C-c>
vnoremap <C-c> "*y<cr>
silent! vunmap <C-x>
vnoremap <C-x> "*ygvd<cr>
silent! iunmap <C-p>
inoremap <C-p> <C-r>*
silent! nunmap <C-p>
nnoremap <C-p> i<C-r>*<esc>

" Store swap files in fixed location, not current directory.
set dir=~/.vimswap//,/var/tmp//,/tmp//,.

function! FileQuit()
    let modified = &modified

    " saving the file if it has changes
    " before quitting
    if modified
        execute "normal! :w\<cr>"
    end

    execute "normal! :bd\<cr>"

endfunction

" shortcut to close the current buffer
nnoremap <Leader>q :call FileQuit()<cr>

" shortcut to highlight a word under cursor
nnoremap <Leader>hw :exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))<cr>

" shortcut to turn off matching
nnoremap <Leader>ho :match none<cr>

" http://vim.wikia.com/wiki/Cleanup_your_HTML
" format html and xml
command! FormatHtml :%!tidy -q -i --show-errors 0
command! FormatXml  :%!tidy -q -i --show-errors 0 -xml

" shortcut to Gundo
" a plugin to view history
nnoremap <Leader>g :GundoToggle<cr>

" http://vim.wikia.com/wiki/Search_only_over_a_visual_range 
function! RangeSearch(direction)
  call inputsave()
  let g:srchstr = input(a:direction)
  call inputrestore()
  if strlen(g:srchstr) > 0
    let g:srchstr = g:srchstr.
          \ '\%>'.(line("'<")-1).'l'.
          \ '\%<'.(line("'>")+1).'l'
  else
    let g:srchstr = ''
  endif
endfunction
vnoremap <silent> s/ :<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
vnoremap <silent> s? :<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>
" EOF

" This uses vimgrep to search for words in
" the current file.
" If found, it opens QuickFix
" If not, echo Not Found
function! SearchVimGrep()
    call inputsave()
    let l:keyword = input('Enter a keyword to search in this file:')
    call inputrestore()
    try

        execute 'vimgrep /'.escape(l:keyword, '/\').'/gj %'
        execute 'cw'
    catch
        execute 'echo "Could not find: '.l:keyword.'"'
    endtry
endfunction
