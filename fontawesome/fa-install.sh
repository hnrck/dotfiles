#!/bin/bash --

TMP_DIR=tmp_dir_to_remove/
FONTS_DIR=$HOME/.fonts/

cd fontawesome/

mkdir $TMP_DIR
cd $TMP_DIR

wget -c https://use.fontawesome.com/releases/v5.0.8/fontawesome-free-5.0.8.zip

unzip -qq fontawesome-free-5.0.8.zip

if [ ! -e $FONTS_DIR ]
then
    mkdir $FONTS_DIR
fi

cp fontawesome-free-5.0.8/use-on-desktop/*.otf $FONTS_DIR

cd ..
rm -rf $TMP_DIR
cd ..
