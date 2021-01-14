SHELL_DOTFILE?=zsh
EDITOR_DOTFILE?=zsh
TERM_DOTFILE?=hyper # sakura

.PHONY=help shell editor term cvs dev

help:
	@ echo "Install specific part of the dotfiles (dry run version)"

all: shell editor term cvs dev

shell: ${SHELL_DOTFILE}
	echo bash ${^}/${^}-install.sh

editor: ${EDITOR_DOTFILE}
	echo bash ${^}/${^}-install.sh

term: ${TERM_DOTFILE}
	echo bash ${^}/${^}-install.sh

cvs: git github
	echo bash git/git-install.sh
	echo bash github/github-install.sh

dev: cpp-dev py-dev haskell-dev

cpp-dev: clang
	echo bash clang/clang-install.sh

py-dev: conda
	echo bash conda/conda-install.sh

haskell-dev: stack
	echo bash stack/stack-install.sh

wm: haskell-dev xmonad
	echo bash xmonad/xmonad-install.sh
