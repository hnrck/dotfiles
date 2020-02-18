#!/bin/bash --

# Constants variable
CONDA_CONF_FILES=(conda)


# Tools
DATE=`date +%Y-%m-%d-%H:%M:%S`

for CONDA_CONF_FILE in "${CONDA_CONF_FILES[@]}"
do
    CONDA_CONF=$HOME/.$CONDA_CONF_FILE
    if [ -e $CONDA_CONF ]
    then
    	mv $CONDA_CONF $CONDA_CONF.$DATE.old
    fi
    
    if [ -L $CONDA_CONF ]
    then
    	unlink  $CONDA_CONF
    fi
    
    ln ./conda/$CONDA_CONF_FILE $CONDA_CONF
done
