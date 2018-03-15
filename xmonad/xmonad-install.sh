#!/bin/bash --

# Constants variable
XMONAD_CONF_FILES=(xmonad.hs xmobar.hs)
XMONAD_DIR=$HOME/.xmonad/


# Tools
DATE=`date +%Y-%m-%d-%H:%M:%S`

if [ -L $XMONAD_DIR ]
then
	unlink $XMONAD_DIR
fi

if [ ! -e $XMONAD_DIR ]
then
     mkdir $XMONAD_DIR
fi

for XMONAD_CONF_FILE in "${XMONAD_CONF_FILES[@]}"
do
    XMONAD_CONF=$XMONAD_DIR/$XMONAD_CONF_FILE

    if [ -L $XMONAD_CONF ]
    then
    	unlink  $XMONAD_CONF
    fi
    
    if [ -e $XMONAD_CONF ]
    then
    	mv $XMONAD_CONF $XMONAD_CONF.$DATE.old
    fi
    
    ln ./xmonad/$XMONAD_CONF_FILE $XMONAD_CONF
done
