" Forget being compatible with good ol' vi
set nocompatible

" Get that filetype stuff happening
if has("autocmd")
    filetype on
    filetype plugin on
    filetype indent on
endif

" Turn on that syntax highlighting
syntax on

" Allow hidden buffers without prompt
set hidden

" Don't update the display while executing macros
set lazyredraw

" At least let yourself know what mode you're in
set showmode

" Enable enhanced command-line completion. Presumes you have compiled
" with +wildmenu.  See :help 'wildmenu'
" set wildmenu

" Turn on line numbering
set number

" Width of tab character
set tabstop=4

" Amount of ws to insert/remove using the indentation commands in normal mode
set shiftwidth=4

" Fine tunes the amount of ws to be inserted (should equal shiftwidth)
set softtabstop=4

" Replace tabs with spaces
set expandtab

" File type-specific whitespace settings
if has("autocmd")
    " Syntax of these languages is fussy over tabs Vs spaces
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    " Custom whitespace settings
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType php setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
endif

" Invisible characters config
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬
"highlight NonText guifg=#272727
"highlight SpecialKey guifg=#272727

" Strip trailing whitespace
" http://vimcasts.org/episodes/tidying-whitespace/
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Remove trailing whitespace automatically when a file is saved
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()


" http://vimcasts.org/episodes/indentation-commands/
" TextMate's key mappings
"nmap <C-[> <<
"nmap <C-]> >>
"vmap <C-[> <gv
"vmap <C-]> >gv

