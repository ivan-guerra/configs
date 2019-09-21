" General settings.
set secure
set mouse=c
set shortmess+=A
set nocompatible

" Set indentation rules.
set smarttab
set expandtab
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4

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
set colorcolumn=110
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
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
" The following mappings allow for bracket/paren/quote auto-completion and escape.
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i
inoremap <C-j> <Esc>/[)}"'\]>]<CR>:nohl<CR>a

" Plugins and plugin configurations. Avoiding use of plug-in managers since
" most of my work is on a closed loop machine.

" File/source tree.
set runtimepath^=~/.vim/bundle/nerdtree-master
let NERDTreeIgnore = ['__pycache__', '\.pyc$', '\.o$', '\.so$', '\.a$', '\.swp', '*\.swp', '\.swo', '\.swn', '\.swh', '\.swm', '\.swl', '\.swk', '\.sw*$', '[a-zA-Z]*egg[a-zA-Z]*', '.DS_Store']
let NERDTreeShowHidden=1
let g:NERDTreeWinPos="left"
let g:NERDTreeDirArrows=1
map <C-n> :NERDTreeToggle<CR>

" WARNING, to use tagbar you have to install CTags on your machine!
set runtimepath^=~/.vim/bundle/tagbar-master
let g:tagbar_autoclose=1
map <C-b> :TagbarToggle<CR>
set tags=./tags,tags;$HOME

" Git.
set runtimepath^=~/.vim/bundle/vim-fugitive-master
set runtimepath^=~/.vim/bundle/vim-gitgutter-master

" Status bar.
set runtimepath^=~/.vim/bundle/vim-airline-master

" Syntax helpers.
set runtimepath^=~/.vim/bundle/syntastic-master
let g:syntastic_check_on_open=1

set runtimepath^=~/.vim/bundle/vim-cpp-enhanced-highlight-master

" Completion.
set runtimepath^=~/.vim/bundle/supertab-master
