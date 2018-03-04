#!/bin/bash --

if [ ! -x "$(command -v stack)" ]
then
    curl -sSL https://get.haskellstack.org/ | sh
fi
