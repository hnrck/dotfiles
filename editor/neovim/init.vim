" File: ~/.SpaceVim.d/init.vim

function! init#before() abort

" Comments in italic with compatible terminal emulator
set t_ZH=[3m
set t_ZR=[23m
highlight Comment cterm=italic

" Useful remap
imap jj <Esc>

set diffopt+=vertical

endfunction
