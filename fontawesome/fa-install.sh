#!/bin/bash --

TMP_DIR=tmp_dir_to_remove/

cd fontawesome/

mkdir $TMP_DIR
cd $TMP_DIR

wget -c https://use.fontawesome.com/releases/v5.0.8/fontawesome-free-5.0.8.zip

unzip fontawesome-free-5.0.8.zip

if [ ! -e ~/.fonts ]
then
    cp fontawesome-free-5.0.8/use-on-desktop/*.otf ~/.fonts
fi

cd ..

rm -rf $TMP_DIR

cd ..
