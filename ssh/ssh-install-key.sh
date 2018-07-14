#!/bin/bash --

gpg2 --gen-key --batch ssh/ssh-sigkey-conf

# SIGKEY=`gpg2 --list-keys | tac | grep -m 1 ssh -A 1 | tail -n 1 | awk '{ print $1 }'`
