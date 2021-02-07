" General settings.
set secure
set mouse=c
set shortmess+=A
set noswapfile
set nocompatible

" Set the runtime path to include Vundle and init plugins.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Git plugins.
Plugin 'https://github.com/tpope/vim-fugitive.git'
Plugin 'https://github.com/airblade/vim-gitgutter.git'

" Status bar.
Plugin 'https://github.com/vim-airline/vim-airline.git'

" File/source tree.
Plugin 'https://github.com/preservim/nerdtree.git'
let NERDTreeIgnore = ['__pycache__', '\.pyc$', '\.o$', '\.so$', '\.a$', '\.swp', '*\.swp', '\.swo', '\.swn', '\.swh', '\.swm', '\.swl', '\.swk', '\.sw*$', '[a-zA-Z]*egg[a-zA-Z]*', '.DS_Store']
let NERDTreeShowHidden=1
let g:NERDTreeWinPos="left"
let g:NERDTreeDirArrows=1
let g:NERDTreeQuitOnOpen=1
map <C-n> :NERDTreeToggle<CR>

" Syntax helpers.
Plugin 'https://github.com/vim-syntastic/syntastic.git'
let g:syntastic_check_on_open=1
let g:syntastic_python_checkers=['flake8']

" WARNING, to use tagbar you have to install CTags on your machine!
set runtimepath^=~/.vim/plugins/tagbar-master
let g:tagbar_autoclose=1
map <C-b> :TagbarToggle<CR>
set tags=./tags,tags;$HOME

Plugin 'https://github.com/majutsushi/tagbar.git'

" Completion.
Plugin 'https://github.com/ervandew/supertab.git'

" Code alignment.
Plugin 'https://github.com/junegunn/vim-easy-align.git'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
if !exists('g:easy_align_delimiters')
    let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['d'] = {
\ 'pattern': ' \ze\S\+\s*[;=]',
\ 'left_margin': 0, 'right_margin': 0
\ } " The d delimiter helps us align on variable declarations (i.e., the var names line up).

call vundle#end()

" Set indentation rules.
set smarttab
set expandtab
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Look and feel and workflow settings.
syntax on
set ruler
set number
set hidden
set autowrite
set incsearch
set ignorecase
set nohlsearch
set backspace=indent,eol,start
set laststatus=2
set fillchars+=vert:\|
set colorcolumn=80
colorscheme jellybeans
highlight ColorColumn ctermbg=darkgray

if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes
    " work properly when Vim is used inside tmux and GNU screen.
    set t_ut=
endif

" Key mappings.
nmap kk <S-:>
imap jj <Esc>
nmap <C-Right> :tabnext<CR>
nmap <C-Left> :tabprevious<CR>
inoremap <C-Z> <C-O>u
inoremap { {<CR><BS>}<Esc>ko
" The following mappings allow for bracket/paren/quote auto-completion and escape.
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i
inoremap <C-j> <Esc>/[)}"'\]>]<CR>:nohl<CR>a
map <C-l> :call VarAlign()<CR>

" Call StripTrailingWhitespaces() on file save.
autocmd BufWritePre * :call StripTrailingWhitespaces()

" Align selected code to follow the MCRT dev style guide.
function VarAlign()
    exe "normal! \e"
    exe ":'<,'>EasyAlign d"
    exe ":'<,'>EasyAlign ="
endfunction

function StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    keepp %s/\s\+$//e
    call cursor(l, c)
endfun
