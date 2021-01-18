" File: ~/.SpaceVim.d/after.vim

" if exists(g:gui_oni)
if exists("g:gui_oni")
  set laststatus=0
  set noshowmode
  set noruler
  set noshowcmd
else
  set laststatus=2
  set showmode
  set showcmd
endif

set wrap! 

inoremap jj <Esc>
" imap hh <Esc>
" set timeoutlen=1000
