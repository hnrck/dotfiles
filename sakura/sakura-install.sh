#!/bin/bash --

# Constants
DOT_CONF=~/.config/

# Tools
DATE=`date +%Y-%m-%d-%H:%M:%S`

# Sakura
SAKURA_DIR=$DOT_CONF/sakura
SAKURA_CONF=$SAKURA_DIR/sakura.conf
mkdir -p $SAKURA_DIR
if [ -e $SAKURA_CONF ]
then
    mv $SAKURA_CONF $SAKURA_CONF.$DATE.old
fi
if [ -L $SAKURA_CONF ]
then
    unlink  $SAKURA_CONF
fi
ln ./sakura/sakura.conf $SAKURA_DIR
