" File: ~/.SpaceVim.d/init.vim

" Always show the status line
set laststatus=2

" Set the shell
set shell=/bin/sh

" Set the term
" set term=screen-256color
" set term=xterm-256color
set t_Co=256
"set t_ut=

" Sets how many lines of history VIM has to remember
set history=700

" Set 7 lines to the cursor - when moving vertically using j/k
"set so=7

" Show matching brackets when text indicator is over them
"set showmatch

" Display tabulations
"set listchars=tab:>-,trail:×,extends:>,precedes:<
"set list

" Comments in italic with compatible terminal emulator
set t_ZH=[3m
set t_ZR=[23m
highlight Comment cterm=italic

" Colors
hi SignColumn term=underline ctermfg=10 ctermbg=0 guifg=#586e75 guibg=#073642
let g:syntastic_loc_list_height=0

" Syntastic
let g:syntastic_c_include_dirs = ['./include', '/usr/include']
let g:syntastic_cpp_include_dirs = ['./include', '/usr/include']

let g:syntastic_cpp_checkers=['clang_check', 'clang_tidy', 'cppcheck', 'cpplint', 'gcc', 'oclint', 'pc_lint', 'vera++']

let g:syntastic_c_compiler = 'clang_check'
let g:syntastic_c_compiler_options = ' -std=c11 -stdlib=libc'

let g:syntastic_c_cppcheck_args = '-q --enable=style'
let g:syntastic_c_clang_check_args = ' -std=c11 -stdlib=libc'

let g:syntastic_cpp_compiler = 'clang_check'
let g:syntastic_cpp_compiler_options = ' -std=c++1z -stdlib=libc++'

let g:syntastic_cpp_cppcheck_args = '-q --enable=style'
let g:syntastic_cpp_clang_check_args = ' -std=c++1z -stdlib=libc++'

" C/C++ tools
let g:C_UseTool_cmake   = 'yes'
let g:C_UseTool_doxygen = 'yes'

" Python
"" let g:python_host_prog = '/usr/bin/python2'
" let g:python3_host_prog = '/usr/bin/python2'
"" let g:python3_host_prog = '/opt/ActivePython-3.6/bin/python3'

" Chromatica
"" if !exists("$LIBCLANG_PATH")
""     let $LIBCLANG_PATH = '/usr/lib/'
"" endif
"" let g:chromatica#libclang_path = expand("$LIBCLANG_PATH")
let g:clamp_autostart = 0

" For vertical diff by default
set diffopt+=vertical

" Useful remap
imap jj <Esc>
imap hh <Esc>
imap <space><space> <Esc>
