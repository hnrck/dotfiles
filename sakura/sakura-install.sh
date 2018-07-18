#!/bin/bash --

# Constants
DOT_CONF=~/.config/

# Tools
DATE=`date +%Y-%m-%d-%H:%M:%S`

# Sakura
SAKURA_DIR=$(readlink -m ${DOT_CONF}/sakura)
SAKURA_CONF=$(readlink -m ${SAKURA_DIR}/sakura.conf)

if [ ${VERBOSE} -eq 1 ]
then
  echo -e "Installing sakura conf ..."
fi

# Creating folder for conf
mkdir -p ${SAKURA_DIR}

# If old conf is a sym link, unlinking it
if [ -L ${SAKURA_CONF} ]
then
  if [ ${VERBOSE} -eq 1 ]
  then
    echo -e "... unlinking old sym link ${SAKURA_CONF} ..."
  fi
  unlink  ${SAKURA_CONF}
fi

# Archiving old conf if exists as file or hard link
if [ -e ${SAKURA_CONF} ]
then
  SAKURA_ARCHIVE=$(readlink -m ${SAKURA_CONF}.${DATE}.old)
  if [ ${VERBOSE} -eq 1 ]
  then
    echo -e "... archiving old file ${SAKURA_CONF} as ${SAKURA_ARCHIVE} ..."
  fi
  mv ${SAKURA_CONF} ${SAKURA_ARCHIVE}
fi

if [ ${VERBOSE} -eq 1 ]
then
  echo -e "... creating link in ${SAKURA_DIR} ..."
fi
# Creating a sym link to the current conf
ln -s `pwd`/sakura/sakura.conf ${SAKURA_CONF}

if [ ${VERBOSE} -eq 1 ]
then
  echo -e "... done."
fi

ln -s `pwd`/sakura/sakura.conf $SAKURA_DIR
