" change leader key
let mapleader = ','

" mapping to find words under cursor
" and to open up quick list
nnoremap f* :vimgrep /<C-r><C-w>/gj %<cr> <bar> :cw<cr>

" mapping to toggle search highlight
nnoremap <Leader>hs :set hlsearch!<cr>

" mapping to toggle cursor line
nnoremap <Leader>cl :set cursorline!<cr>

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

" shortcuts to edit tmux config
nnoremap <leader>et :e ~/.tmux.conf<cr>

" shortcuts to edit .bash_profile
nnoremap <leader>eb :e ~/.bash_profile<cr>

" shortcut to save the current document
nnoremap <Leader>s :w<CR>

" shortcut to move between windows
nnoremap <Leader>nw <C-w><C-w>

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
vnoremap <C-c> "*y
silent! vunmap <C-x>
vnoremap <C-x> "*ygvd
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

    execute "normal! :q\<cr>"

endfunction

" shortcut to close the current buffer
nnoremap <Leader>q :call FileQuit()<cr>

" shortcut to highlight a word under cursor
nnoremap <Leader>hw :exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))<cr>

" shortcut to turn off matching
nnoremap <Leader>ho :match none<cr>
