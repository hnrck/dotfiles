#!/bin/bash --

# Constants variable
TMUX_DIR=$HOME/.tmux
TMUX_CONF=$HOME/.tmux.conf
TMUX_CONF_LOCAL=$HOME/.tmux.conf.local

# Tools
DATE=`date +%Y-%m-%d-%H:%M:%S`

# TMUX
if [ -L $TMUX_DIR ]
then
	unlink  $TMUX_DIR
fi
if [ -e $TMUX ]
then
    mv $TMUX $TMUX.$DATE.old
fi
git clone https://github.com/gpakosz/.tmux.git $TMUX_DIR

# TMUX configuration
if [ -L $TMUX_CONF ]
then
	unlink  $TMUX_CONF
fi
if [ -e $TMUX_CONF ]
then
    mv $TMUX_CONF $TMUX_CONF.$DATE.old
fi
ln -s -f $TMUX_DIR/.tmux.conf $TMUX_CONF

# TMUX local configuration
if [ -L $TMUX_CONF_LOCAL ]
then
	unlink  $TMUX_CONF_LOCAL
fi
if [ -e $TMUX_CONF_LOCAL ]
then
    mv $TMUX_CONF_LOCAL $TMUX_CONF_LOCAL.$DATE.old
fi
ln -s -f tmux/tmux.conf.local $TMUX_CONF_LOCAL
