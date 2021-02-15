###############################################################################
# Configuration                                                               #
###############################################################################

# Configuration choice
EDITOR_DOTFILE?=neovim
SHELL_DOTFILE?=zsh
TERM_DOTFILE?=hyper # sakura

# Local path configuration
SCRIPTS_DIR?=scripts
CACHE_DIR?=cache

LINKER=${SCRIPTS_DIR}/dotfile_linker.sh

.PHONY=help shell editor term cvs dev

###############################################################################
# Help                                                                        #
###############################################################################

help:
	@ echo "Install specific part of the dotfiles"

###############################################################################
# Default installation                                                        #
###############################################################################

all: cvs dev editor shell term tools

###############################################################################
# High-level categories installers                                            #
###############################################################################

# CVS
cvs: git

# Developer tools
dev: cpp-dev py-dev idea

# Fonts
fonts:

# Misc
misc:

# Editor
editor: ${EDITOR_DOTFILE}

# Shell
shell: ${SHELL_DOTFILE}

# Term
term: ${TERM_DOTFILE}

# Tools
tools: tmux curl wget

# Window manager
wm: haskell-dev xmonad

###############################################################################
# Specific installers                                                         #
###############################################################################

# Clang
clang:
	@ ${LINKER} --dotfile clang_format --source-location dev/clang
	@ ${LINKER} --dotfile zshrc_llvm --source-location dev/clang --target-file zshrc_llvm --target-location ${HOME}/.zshrc.d

# Conda
conda: zshrcd
	@ ${LINKER} --dotfile condarc --source-location dev/conda
	@ ${LINKER} --dotfile zshrc_conda --source-location dev/conda --target-file zshrc_conda --target-location ${HOME}/.zshrc.d

# Curl
curl:
	@ ${LINKER} --dotfile curlrc --source-location tools/curl

# CPP configuration
cpp-dev: clang

# Haskell configuration
haskell-dev: stack

# Hyper
hyper:
	@ ${LINKER} --dotfile hyper.js --source-location term/hyper

# Idea
idea:
	@ ${LINKER} --dotfile ideavimrc --source-location editor/idea

# Neovim
neovim: spacevim
	@ mkdir -p ${HOME}/.SpaceVim.d/autoload
	@ ${LINKER} --dotfile init.toml --source-location editor/neovim --target-file init.toml --target-location ${HOME}/.SpaceVim.d/
	@ ${LINKER} --dotfile init.vim --source-location editor/neovim --target-file init.vim --target-location ${HOME}/.SpaceVim.d/autoload
	@ ${LINKER} --dotfile after.vim --source-location editor/neovim --target-file after.vim --target-location ${HOME}/.SpaceVim.d/autoload

spacevim:
	curl -sLf https://spacevim.org/install.sh | bash 2> /dev/null

# Python configuration
py-dev: py-venv

# Python virtualenv
py-venv:
	python3 -m virtualenv ${CACHE_DIR}/venv 1> /dev/null
	@ ${LINKER} --dotfile venv --source-location ${CACHE_DIR}

# Git
git:
	@ ${LINKER} --dotfile gitconfig --source-location cvs/git
	@ ${LINKER} --dotfile gitignore --source-location cvs/git

# sakura
sakura:
	@ ${LINKER} --dotfile sakura.conf --source-location term/sakura --target-file sakura.conf --target-location ${HOME}/.conf/sakura

# ssh
ssh:
	echo "Please find info about ssh configuration in tools/ssh"

# Stack
stack:
	@ ${LINKER} --dotfile zshrc_stack --source-location dev/stack --target-file zshrc_stack --target-location ${HOME}/.zshrc.d

# Thunderbird
thunderbird:

# Tmux
tmux: tmux-cache
	@ ${LINKER} --dotfile tmux.conf --source-file .tmux.conf --source-location ${CACHE_DIR}/tmux --target-file .tmux.conf
	@ ${LINKER} --dotfile tmux.conf.local --source-location tmux

tmux-cache:
	git -C ${CACHE_DIR}/tmux pull 1> /dev/null 2> /dev/null || git clone https://github.com/gpakosz/.tmux.git ${CACHE_DIR}/tmux 1> /dev/null 2> /dev/null

# Wget
wget:
	@ ${LINKER} --dotfile wgetrc --source-location tools/wget

# Oh my ZSH
omz:
	@ rm -rf ${HOME}/.oh-my-zsh
	@ curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh 

spaceship:
	@ rm -rf "${HOME}/.oh-my-zsh/custom/themes/spaceship-prompt"
	@ git clone https://github.com/denysdovhan/spaceship-prompt.git "${HOME}/.oh-my-zsh/custom/themes/spaceship-prompt" --depth=1
	@ ln -s "${HOME}/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "${HOME}/.oh-my-zsh/custom/themes/spaceship.zsh-theme" 

# ZSH
zsh: shell/zsh omz zshrcd
	@ ${LINKER} --dotfile zshrc --source-location shell/zsh
	@ ${LINKER} --dotfile zshrc_aliases --source-location shell/zsh
	@ ${LINKER} --dotfile zshrc_paths --source-location shell/zsh
	@ ${LINKER} --dotfile zshrc_style --source-location shell/zsh

zshrcd:
	@ mkdir -p ${HOME}/.zshrc.d

###############################################################################
# Utils                                                                       #
###############################################################################

clean-cache:
	@ git clean -dxff ${CACHE_DIR}

###############################################################################
# Dotfiles                                                                    #
###############################################################################

dotfiles: dotfiles_edit dotfiles_cd dotfiles_install

dotfiles_makefile := $(abspath $(lastword $(MAKEFILE_LIST)))
dotfiles_dir := $(dir $(dotfiles_makefile))

dotfiles_edit: zshrcd
	@ echo "alias dotfiles_edit=\"nvim ${dotfiles_makefile}\"" > ${HOME}/.zshrc.d/zshrc_dotfiles_edit

dotfiles_cd: zshrcd
	@ echo "alias dotfiles_cd=\"cd ${dotfiles_dir}\"" > ${HOME}/.zshrc.d/zshrc_dotfiles_cd

dotfiles_install: zshrcd
	@ echo "alias dotfiles_install=\"make -C ${dotfiles_dir}\"" > ${HOME}/.zshrc.d/zshrc_dotfiles_install
