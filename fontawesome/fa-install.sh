#!/bin/bash --

FONTAWESOME_VERSION=5.0.8
FONTAWESOME=fontawesome-free-${FONTAWESOME_VERSION}

FONTS_DIR=${HOME}/.fonts

TMP_DIR=tmp_dir_to_remove/
FONTS_DIR=$HOME/.fonts/

cd fontawesome/

if [ -e "${FONTS_DIR}/Font Awesome 5 Brands-Regular-400.otf" ] \
  && [ -e "${FONTS_DIR}/Font Awesome 5 Free-Regular-400.otf" ] \
  && [ -e "${FONTS_DIR}/Font Awesome 5 Free-Solid-900.otf" ]
then
  exit
fi

mkdir ${TMP_DIR}
cd ${TMP_DIR}

wget -c https://use.fontawesome.com/releases/v${FONTAWESOME_VERSION}/${FONTAWESOME}.zip

unzip ${FONTAWESOME}.zip

if [ ! -e ${FONTS_DIR} ]
then
  mkdir -p ${FONTS_DIR}
fi

cp fontawesome-free-5.0.8/use-on-desktop/*.otf ${FONTS_DIR}

cd ..

rm -rf --preserve-root -- ${TMP_DIR}

cd ..
