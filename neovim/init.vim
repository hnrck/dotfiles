" File: ~/.SpaceVim.d/init.vim

" Dark powered mode of SpaceVim, generated by SpaceVim automatically.
let g:spacevim_enable_debug = 1
let g:spacevim_realtime_leader_guide = 1
call SpaceVim#layers#load('lang#go')
call SpaceVim#layers#load('lang#c')
call SpaceVim#layers#load('incsearch')
" call SpaceVim#layers#load('lang#lua')
" call SpaceVim#layers#load('lang#perl')
" call SpaceVim#layers#load('lang#rust')
"call SpaceVim#layers#load('lang#java')
"call SpaceVim#layers#load('lang#javascript')
call SpaceVim#layers#load('lang#vim')
call SpaceVim#layers#load('lang#python')
call SpaceVim#layers#load('lang#xml')
call SpaceVim#layers#load('lang#haskell')
"call SpaceVim#layers#load('lang#elixir')
" call SpaceVim#layers#load('tools#screensaver')
call SpaceVim#layers#load('shell')   

let g:spacevim_enable_vimfiler_welcome = 1
let g:spacevim_enable_debug = 1
let g:deoplete#auto_complete_delay = 150
let g:spacevim_enable_tabline_filetype_icon = 1
let g:spacevim_enable_os_fileformat_icon = 1
let g:spacevim_buffer_index_type = 1
let g:neomake_vim_enabled_makers = ['vimlint', 'vint']
if has('python3')
    let g:ctrlp_map = ''
    nnoremap <silent> <C-p> :Denite file_rec<CR>
endif
let g:clang2_placeholder_next = ''
let g:clang2_placeholder_prev = ''

" Always show the status line
set laststatus=2

" Set the shell
set shell=/bin/sh

" Set the term
"set term=screen-256color
"set term=xterm-256color-bce
"set term=xterm-256color
"set t_Co=256
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

" Set Color of colum
"highlight ColorColumn ctermbg=black

"highlight CursorLine ctermbg=black
"map <silent><F3> :NEXTCOLOR<cr>
"map <silent><F2> :PREVCOLOR<cr>

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

" Here are some basic customizations, please refer to the top of the vimrc
" file for all possible options:
let g:spacevim_default_indent = 2 " 2, 4, 8

let g:spacevim_max_column     = 100 " 80, 100, 120

let g:spacevim_plugin_manager = 'dein'  " neobundle or dein or vim-plug

" Change the default directory where all miscellaneous persistent files go.
" By default it is ~/.cache/vimfiles.
" let g:spacevim_plugin_bundle_dir = "/some/place/else"

" By default, language specific plugins are not loaded. This can be changed
" with the following:
" let g:spacevim_plugin_groups_exclude = ['ruby', 'python']

" If there are groups you want always loaded, you can use this:
" let g:spacevim_plugin_groups_include = ['go']

" Alternatively, you can set this variable to load exactly what you want:
" let g:spacevim_plugin_groups = ['core', 'web']

" If there is a particular plugin you don't like, you can define this
" variable to disable them entirely:
" let g:spacevim_disabled_plugins=['vim-foo', 'vim-bar']
let g:spacevim_disabled_plugins=['deoplete-clang2']

let g:spacevim_custom_plugins = [
            \ ['Shougo/deoplete-clangx'],
            \ ['eagletmt/ghcmod-vim'],
            \ ['bitc/vim-hdevtools'],
            \ ['Twinside/vim-hoogle'],
            \ ['rhysd/vim-clang-format'],
            \ ['vhdirk/vim-cmake'],
            \ ['arecarn/vim-selection'],
            \ ['rhysd/vim-grammarous'],
            \ ['severin-lemaignan/vim-minimap'],
            \ ['tyrannicaltoucan/vim-deep-space'],
            \ ]

set background=dark
set termguicolors

" let g:spacevim_colorscheme    = 'NeoSolarized'
let g:spacevim_colorscheme    = 'deep-space'
let g:spacevim_colorscheme_bg = 'dark'

" Chromatica
if !exists("$LIBCLANG_PATH")
    let $LIBCLANG_PATH = '/usr/lib/'
endif

" For vertical diff by default
set diffopt+=vertical

let g:chromatica#libclang_path = expand("$LIBCLANG_PATH")
