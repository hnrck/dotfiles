#!/bin/bash --

gpg2 --gen-key --batch git/git-sigkey-conf

SIGKEY=`gpg2 --list-keys --keyid-format long | tac | grep -m 1 Git -A 1 | tail -n 1 | awk '{ print $2 }' | sed 's/^.*\///'`

echo -e "Please add:\n--------"
echo -e "[user]\n\tsigningkey = $SIGKEY"
echo -e "--------"
echo -e "in your .gitconfig file"
echo -e ""
echo -e "You might want to export this one:"

gpg2 --armor --export $SIGKEY
