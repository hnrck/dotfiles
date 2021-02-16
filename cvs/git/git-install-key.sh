#!/bin/bash --

conf=${1}
GPG=gpg2

${GPG} --gen-key --batch ${conf}

SIGKEY=$(${GPG} --list-keys --keyid-format long | tac | grep -m 1 Git -A 1 | tail -n 1 | awk '{ print $2 }' | sed 's/^.*\///')

echo -e "Please add:\n--------"
echo -e "[user]\n\tsigningkey = $SIGKEY"
echo -e "--------"
echo -e "in your .gitconfig file"
echo -e ""
echo -e "You might want to export this one:"

${GPG} --armor --export $SIGKEY
