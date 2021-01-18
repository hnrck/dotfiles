#!/usr/bin/env bash

if [ -z "${PYTHON}" ]; then
  PYTHON=python3
fi


PYTHONPATH=${PYTHONPATH}:scripts ${PYTHON} scripts/dotfile_linker "${@}"
