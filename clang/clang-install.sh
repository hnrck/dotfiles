#!/bin/bash --

# Constants variable
CLANG_CONF_FILE=clang_format

# Tools
DATE=`date +%Y-%m-%d-%H:%M:%S`

CLANG_CONF=$HOME/.$CLANG_CONF_FILE
if [ -e $CLANG_CONF ]
then
	mv $CLANG_CONF $CLANG_CONF.$DATE.old
fi

if [ -L $CLANG_CONF ]
then
	unlink  $CLANG_CONF
fi

ln ./clang/$CLANG_CONF_FILE $CLANG_CONF
