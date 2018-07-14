#!/bin/bash --

# Set VERBOSE to 1 for info during installation, else 0
export VERBOSE=1

# Confs to install
CONFS=(
  # ZSH confs
  zsh/zsh-install.sh

  # Git
  git/git-install.sh

  # NeoVim
  neovim/neovim-install.sh

  # Sakura conf
  sakura/sakura-install.sh

  # Clang
  clang/clang-install.sh

  # Stack
  stack/stack-install.sh

  # XMonad
  xmonad/xmonad-install.sh

  # Font Awesome
  fontawesome/fa-install.sh

  # Github
  github/github-clone.sh
)

for CONF in ${CONFS[@]}
do
  if [ ${VERBOSE} -eq 1 ]
  then 
    echo -e "file: ${CONF}"
  fi
  bash ${CONF}
  if [ ${VERBOSE} -eq 1 ]
  then 
    echo -e ""
  fi
done
