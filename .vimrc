" General settings.
set exrc
set secure
set mouse=c
set shortmess+=A
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugin manager
Plugin 'VundleVim/Vundle.vim'

" File/source tree
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'

" Completion
Plugin 'ervandew/supertab'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Syntax helpers
Plugin 'scrooloose/syntastic'
Plugin 'octol/vim-cpp-enhanced-highlight'

" Status bar
Plugin 'bling/vim-airline'

" Color schemes
Plugin 'flazz/vim-colorschemes'

call vundle#end()
filetype plugin indent on

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

" Plugins and plugin configurations

" File/source tree.
let NERDTreeIgnore = ['__pycache__', '\.pyc$', '\.o$', '\.so$', '\.a$', '\.swp', '*\.swp', '\.swo', '\.swn', '\.swh', '\.swm', '\.swl', '\.swk', '\.sw*$', '[a-zA-Z]*egg[a-zA-Z]*', '.DS_Store']
let NERDTreeShowHidden=1
let g:NERDTreeWinPos="left"
let g:NERDTreeDirArrows=1
map <C-n> :NERDTreeToggle<CR>

" WARNING, to use tagbar you have to install CTags on your machine!
let g:tagbar_autoclose=1
map <C-b> :TagbarToggle<CR>
set tags=./tags,tags;$HOME

" Syntax helpers.
let g:syntastic_check_on_open=1
