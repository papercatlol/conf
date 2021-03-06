
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searchleing
" for python(stolen from habr):
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab "use spaces instead of tabs
set softtabstop=4 "tab = 4 spaces 
set nu "line numeration
set  t_Co=256
colorscheme jellybeans
let mapleader = "\<Space>"

"%number%+Enter to go to the line %number%
"Backspace to go to the beginning of the file
nnoremap <CR> G
nnoremap <BS> gg
"Quick save file
nnoremap <Leader>w :w<CR>
"Enter visual block mode with <Space-v>
nmap <Leader>v <c-V>
"Copy & Paste:
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
"Tab to navigate through tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
"Space+Space for vim native autocompletion
imap <C-Space> <C-x><C-i>
imap <C-@> <C-Space>
nnoremap <Leader>c :make %:r <CR>
nnoremap <Leader>r :! ./%:r <CR>
set laststatus=2
set statusline+=%F
set ignorecase
set smartcase 
"dmenu thing. Fuck you nerdtree:
function! Chomp(str)
 return substitute(a:str, '\n$', '', '')
endfunction

function! DmenuOpen(cmd)
 let fname = Chomp(system("find .  -type f |  dmenu -i -p \">\" -l 20 -fn -xos4-terminus-medium-r-*-*-14-* -b -nf white -sb gray -sf black "))
"let fname = Chomp(system("git ls-files | dmenu -i -l 20 -p " . a:cmd))
"let fname = Chomp(system("find . | dmenu -i -p -fn -xos4-terminus-medium-r-*-*-14-* -b -nf white -sb gray -sf black" . a:cmd))
 if empty(fname)
   return
 endif
 execute a:cmd . " " . fname

endfunction

"use ctrl-t to open file in a new tab
"use ctrl-f to open file in current buffer
map <Leader>t :call DmenuOpen("tabe")<cr>
map <Leader>f :call DmenuOpen("e")<cr>


"
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
