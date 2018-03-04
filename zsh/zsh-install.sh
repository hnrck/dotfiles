#!/bin/bash --

# Constants variable
ZSH_CONF_FILES=(zshrc zshrc_paths zshrc_style zshrc_aliases)
ZSH_DIR=$HOME/.oh-my-zsh/
ZSH_CUSTOM=$ZSH_DIR/custom/


# Tools
DATE=`date +%Y-%m-%d-%H:%M:%S`

# Oh-my-ZSH
if [ ! -e $HOME/.oh-my-zsh ]
then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Spaceship theme
if [ ! -e $ZSH_CUSTOM/themes/spaceship-prompt ]
then
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
fi
if [ ! -e $ZSH_CUSTOM/themes/spaceship.zsh-theme ]
then
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
fi

for ZSH_CONF_FILE in "${ZSH_CONF_FILES[@]}"
do
    ZSH_CONF=$HOME/.$ZSH_CONF_FILE
    if [ -e $ZSH_CONF ]
    then
    	mv $ZSH_CONF $ZSH_CONF.$DATE.old
    fi
    
    if [ -L $ZSH_CONF ]
    then
    	unlink  $ZSH_CONF
    fi
    
    ln ./zsh/$ZSH_CONF_FILE $ZSH_CONF
done
