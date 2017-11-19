set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'jiangmiao/auto-pairs'

call vundle#end()
filetype plugin indent on

" Theme and colors stuff
syntax enable
set background=dark
colorscheme generic

" General stuff
set exrc
set number
set modifiable
set noswapfile
set noshowcmd
set ruler
" Always display statusline
set laststatus=2
" Update files changed outside vim
set autoread

" Ignore case in search
set ignorecase
set incsearch

" Seperator character for vertical split (currently a space)
set fillchars+=vert:\ 
set scrolloff=10         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
set cursorline

" Use tabs instead of spaces
set noexpandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=4
set tabstop=4

" Make lines not automatically move to next line when buffer width is small
set nowrap

set ai "Auto indent

set secure
