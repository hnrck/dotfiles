#!/bin/bash --

# Constants variable
NEOVIM_TOML_FILE=init.toml
NEOVIM_VIM_FILE=init.vim
NEOVIM_DIR=$HOME/.SpaceVim/
NEOVIM_LOCAL_DIR=$HOME/.SpaceVim.d/


# Tools
DATE=`date +%Y-%m-%d-%H:%M:%S`

if [ ! -e $NEOVIM_DIR ]
then
    curl -sLf https://spacevim.org/install.sh | bash
fi


NEOVIM_CONF=$NEOVIM_LOCAL_DIR/$NEOVIM_TOML_FILE
if [ -e $NEOVIM_CONF ]
then
	mv $NEOVIM_CONF $NEOVIM_CONF.$DATE.old
fi

if [ -L $NEOVIM_CONF ]
then
	unlink  $NEOVIM_CONF
fi

ln ./neovim/$NEOVIM_TOML_FILE $NEOVIM_CONF


NEOVIM_LOCAL_DIR=${NEOVIM_LOCAL_DIR}"/autoload"
NEOVIM_CONF=$NEOVIM_LOCAL_DIR/$NEOVIM_VIM_FILE
if [ ! -e $NEOVIM_LOCAL_DIR ]
then
	mkdir -p ${NEOVIM_LOCAL_DIR}
fi

if [ -e $NEOVIM_CONF ]
then
	mv $NEOVIM_CONF $NEOVIM_CONF.$DATE.old
fi

if [ -L $NEOVIM_CONF ]
then
	unlink  $NEOVIM_CONF
fi

ln ./neovim/$NEOVIM_TOML_FILE $NEOVIM_CONF
