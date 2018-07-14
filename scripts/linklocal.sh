#!/usr/bin/bash -

# linklocal.sh
#
# Create a link for a executable in the local bin.
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
    echo -e "$script_name <to_link> [<link_name>]"
    echo -e ""
    if [ -n "${LOCAL_INSTALL_DIR+1}" ]; then
        echo -e "\tThe link will be make in \$LOCAL_INSTALL_DIR: \"$LOCAL_INSTALL_DIR\"."
    else
        echo -e "\tThe link will be make in $fallback_install_dir, you can change it by setting \$LOCAL_INSTALL_DIR."
    fi
    echo -e "\tif <link_name> is not provided, the link name will be the file to link without its extension."
    echo -e ""
    echo -e "examples:"
    echo -e "\t$script_name my/path/to/toto.sh -> create a link 'toto' in the install dir."
    echo -e "\t$script_name toto.sh tata -> create a link 'tata' in the install dir."
}

# Function linker
#
# Create an executable link in the install directory
#
# Args:
#   $1 the executable to link
#   $2 [optional] the name of the link
# Return:
#   0 if OK
#   1 if the arguments are not provided
#   2 if the link already exist
#   3 if the first argument is not executable
function linker() {
    if [[ $# -gt 0 ]]; then
        if [ -n "${LOCAL_INSTALL_DIR+1}" ]; then
            install_dir=$LOCAL_INSTALL_DIR
        else
            install_dir=$fallback_install_dir
        fi
        if [[ $# -eq 2 ]]; then
            install_name=$2
        else
            install_name=$(basename "${1%.*}")
        fi

        if [[ ! -x $1 ]]; then
            echo -e "Error, file $1 is not an executable.\n"
            helper
            exit 3
        fi

        link=$install_dir/$install_name

        if [ -e ${link} ]; then
            echo -e "Error, link $link already exists.\n"
            helper
            exit 2
        else
            link=$(readlink -m $link)
            echo -e "Creating link $link, targeting `pwd`/$1."
            ln -s -f `pwd`/$1 $link
        fi

    else
        echo -e "Error, 1 or 2 arguments needed.\n"
        helper
        exit 1
    fi

    exit 0
}

linker $*
