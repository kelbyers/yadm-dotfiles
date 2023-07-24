" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible


let $CACHE = expand('~/.cache')
"
" Set dein base path (required)
let s:dein_base = $CACHE .. '/dein'

if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dein_src = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_src)
    let s:dein_src = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_src)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_src
    endif
  endif
  execute 'set runtimepath^=' .. substitute(
        \ fnamemodify(s:dein_src, ':p') , '[/\\]$', '', '')
endif

" Call dein initialization (required)
call dein#begin(s:dein_base)

call dein#add(s:dein_src)

" Your plugins go here:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('wsdjeg/dein-ui.vim')
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

" Finish dein initialization (required)
call dein#end()

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

" Uncomment if you want to install not-installed plugins on startup.
"if dein#check_install()
" call dein#install()
"endif

set number
set smartindent
set shiftwidth=4
set laststatus=2
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set colorcolumn=80


if has("gui_running")
    colorscheme desert
    " autocmd! BufEnter,BufNewFile *.feature colo darkblue
    " autocmd! BufLeave *_steps.py,*.feature colo desert
    " autocmd! BufEnter,BufNewFile *_steps.py colo aiseered
    set guifont=HackNFM-Regular:h13
    if !has("gui_macvim")
	set lines=35
	set columns=90
    endif
    set showtabline=2
endif

