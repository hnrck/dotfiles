#!/usr/bin/bash -

# unlinklocal.sh
#
# Remove a link for a executable from the local bin.
# By default, the local bin is in ~/.local/bin. This can be set with the variable LOCAL_INSTALL_DIR.

# The fallback install directory, if none is set.
fallback_install_dir=$HOME/.local/bin/

# The name of the script for the helper.
script_name=$(basename $0)

# Function helper
#
# Print the help message.
#
# Args:
#   None
# Return:
#   Nothing
function helper() {
    echo -e "$SCRIPT_NAME <link_name>"
    echo -e ""
    echo -e "\tRemove a link for a executable from the local bin."
    if [ -n "${LOCAL_INSTALL_DIR+1}" ]; then
        echo -e "\tThe link will be removed from \$LOCAL_INSTALL_DIR: \"$LOCAL_INSTALL_DIR\"."
    else
        echo -e "\tThe link will be removed from $FALLBACK_INSTALL_DIR, you can change it by setting \$LOCAL_INSTALL_DIR."
    fi
    echo -e ""
    echo -e "examples:"
    echo -e "\t$SCRIPT_NAME my/path/to/toto.sh -> create a link 'toto' in the install dir."
    echo -e "\t$SCRIPT_NAME toto.sh tata -> create a link 'tata' in the install dir."
}

# Function unlinker
#
# Remove a link from the install directory
#
# Args:
#   $1 the link name to remove
# Return:
#   0 if OK
#   1 if the argument is not provided
#   2 if the link does not exist
function unlinker() {
    if [[ $# -eq 1 ]]; then
        if [[ -n "${LOCAL_INSTALL_DIR+1}" ]]; then
            install_dir=$LOCAL_INSTALL_DIR
        else
            install_dir=$fallback_install_dir
        fi

        link=$install_dir/$1

        if [[ ! -e ${link} ]]; then
            echo -e "Error, link $link does not exists.\n"
            helper
            exit 2
        else
            targeted=$(readlink -m $link)
            echo -e "Removing link $link, targeting $targeted."
            unlink $link
        fi

    else
        echo -e "Error, 1 argument needed.\n"
        helper
        exit 1
    fi

    exit 0
}

unlinker $*
