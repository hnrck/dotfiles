#!/bin/bash --

# Constants variable
IDEAVIMRC_CONF_FILE=ideavimrc

# Tools
DATE=$(date +%Y-%m-%d-%H:%M:%S)

IDEAVIMRC_CONF=$HOME/.$IDEAVIMRC_CONF_FILE
if [ -e $IDEAVIMRC_CONF ]; then
  mv $IDEAVIMRC_CONF $IDEAVIMRC_CONF.$DATE.old
fi

if [ -L $IDEAVIMRC_CONF ]; then
  unlink $IDEAVIMRC_CONF
fi

ln ./idea/$IDEAVIMRC_CONF_FILE $IDEAVIMRC_CONF
