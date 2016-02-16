" Forget being compatible with good ol' vi
set nocompatible

" Get that filetype stuff happening
if has("autocmd")
    filetype on
    filetype plugin on
    filetype indent on
endif

" https://github.com/tpope/vim-pathogen
" https://github.com/scrooloose/syntastic
execute pathogen#infect()

" Allow hidden buffers without prompt
set hidden

" Don't update the display while executing macros
set lazyredraw

" At least let yourself know what mode you're in
set showmode

" Enable enhanced command-line completion. Presumes you have compiled
" with +wildmenu.  See :help 'wildmenu'
" set wildmenu
" Set command-line completion to behave like bash
set wildmode=longest,list

" Color ------------------------------------ "
" Turn on that syntax highlighting
syntax on
" set proper colors for terminal vim
set t_Co=256
" Set default color scheme
colorscheme default
" colorscheme hojberg

" Turn on line numbering
set number

" WHITESPACE SETTINTGS
"
" Width of tab character
set tabstop=2
" Amount of ws to insert/remove using the indentation commands in normal mode
set shiftwidth=2
" Fine tunes the amount of ws to be inserted (should equal shiftwidth)
set softtabstop=2
" Replace tabs with spaces
set expandtab

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

" Files ------------------------------------ "

" Drupal *.module and *.install files.
" https://gist.github.com/sanguis/903741#file-vimrc-L35
augroup module
  autocmd BufRead,BufNewFile *.module set filetype=php
  autocmd BufRead,BufNewFile *.install set filetype=php
augroup END

autocmd BufNewFile,BufRead *.ejs set filetype=html.js
autocmd BufNewFile,BufRead *.jst set filetype=html.js
autocmd BufNewFile,BufRead *.handlebars set filetype=html.js
autocmd BufNewFile,BufRead *.hbs set filetype=html.js
autocmd BufNewFile,BufRead *.less set filetype=less
autocmd BufNewFile,BufRead {Guardfile,Gemfile,Rakefile,Vagrantfile,Thorfile} set filetype=ruby
autocmd BufNewFile,BufRead *.json set filetype=javascript
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html']

" File type-specific whitespace settings
if has("autocmd")
    " Syntax of these languages is fussy over tabs Vs spaces
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab

    " Custom whitespace settings
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType php setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType pp setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType python setlocal sw=4 ts=4 sts=4 expandtab
    "autocmd FileType python setlocal shiftround
    "autocmd FileType python setlocal autoindent
    autocmd FileType python setlocal textwidth=79
    autocmd FileType cpp setlocal sw=4 ts=4 sts=4 expandtab
endif

" Colorcolumn
" set cc=80

" Netrw ---------------------------------------"
let g:netrw_list_hide= '.*\.sw(p|o),.*\.pyc$'

" Backup ------------------------------------- "
" set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set noswapfile " no swap files

" <leader> ------------------------------------ "
let g:mapleader = '\'

" Mappings ------------------------------------ "
nnoremap <Leader>n :Explore<CR>

" Set shell to be an interactive login shell
" (so we can use aliases from our bash profile)
"set shell=/bin/bash\ --login
"set shellcmdflag="-ic"

" http://vimcasts.org/episodes/indentation-commands/
" TextMate's key mappings
"nmap <C-[> <<
"nmap <C-]> >>
"vmap <C-[> <gv
"vmap <C-]> >gv

"if FileType != python
"  execute pathogen#helptags()
"endif

" Screwing around with omnicomplete
" autocmd FileType javascript setlocal include=^.*require\(
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType javascript imap . .<c-x><c-o>
" autocmd FileType javascript imap requi require("<c-x><c-o>
" imap <c-space> <c-x><c-o>
" imap <tab><tab> <c-x><c-o> " This makes regular tabing very difficult

" See :help 'complete'
" autocmd FileType javascript setlocal complete='i,t'

" http://vim.wikia.com/wiki/VimTip1386
set completeopt=menu,longest " add 'preview' to see documentation
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" https://stackoverflow.com/questions/7103173/
" hi Search guibg=peru guifg=wheat
hi Search cterm=NONE ctermfg=black ctermbg=grey

let g:syntastic_python_checkers = ['pylint']
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['pp', 'php', 'js', 'css', 'html', 'xml', 'rb', 'json', 'yaml', 'yml'],
                           \ 'passive_filetypes': ['java', 'python'] }

let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++14' " -stdlib=libc++'
let g:syntastic_javascript_checkers=["eslint"]
let g:syntastic_enable_js_checker = 1

" Disable arrow keys so I learn to use h,j,k,l instead!
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Highlight and jump to incomplete search results. See :h 'incsearch'
set incsearch

" Always show at least one line above/below the cursor
set scrolloff=1
set sidescrolloff=5

" Status bar when errors occur (equivalent to default)
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Use the location list when errors occur
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Enable matchit
runtime macros/matchit.vim

" Resize splits when the window is resized
autocmd VimResized * :wincmd =

" Marks ---------------------------------- "
"let g:showmarks_marks = "abcdefhjkln"
