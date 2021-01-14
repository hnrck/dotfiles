#!/bin/bash --

# Constants variable
HYPER_CONF_FILE=hyper.js

# Tools
DATE=$(date +%Y-%m-%d-%H:%M:%S)

HYPER_CONF=$HOME/.$HYPER_CONF_FILE
if [ -e $HYPER_CONF ]; then
  mv $HYPER_CONF $HYPER_CONF.$DATE.old
fi

if [ -L $HYPER_CONF ]; then
  unlink $HYPER_CONF
fi

ln ./hyper/$HYPER_CONF_FILE $HYPER_CONF
