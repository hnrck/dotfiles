#!/bin/bash --

# Constants variable
GIT_CONF_FILES=(gitconfig gitignore)


# Tools
DATE=`date +%Y-%m-%d-%H:%M:%S`

for GIT_CONF_FILE in "${GIT_CONF_FILES[@]}"
do
    GIT_CONF=$HOME/.$GIT_CONF_FILE
    if [ -e $GIT_CONF ]
    then
    	mv $GIT_CONF $GIT_CONF.$DATE.old
    fi
    
    if [ -L $GIT_CONF ]
    then
    	unlink  $GIT_CONF
    fi
    
    ln ./git/$GIT_CONF_FILE $GIT_CONF
done
