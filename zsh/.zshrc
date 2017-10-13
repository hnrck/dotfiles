if [ -d $HOME/.oh-my-zsh ]
then
    export ZSH=$HOME/.oh-my-zsh

    HIST_STAMPS="dd/mm/yyyy"

    if [ -f $HOME/.zshrc_style ]
    then
        source $HOME/.zshrc_style
    fi

    # ZSH plugins
    plugins=(
      git
      svn
      cabal
      dnf
      fedora
      git-extras
      gitfast
      git-flow
      git-flow-avh
      github
      git-hubflow
      gitignore
      git-remote-branch
      man
      pyenv
      pylint
      python
      repo
      sudo
      rvm-prompt
      rbenv
    )

    alias zshconfig="$EDITOR ~/.zshrc"
    alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
fi

# Basic PATH settings.
# export PATH= # Uncomment if you want a clean PATH.
export PATH=$PATH:/sbin
export PATH=$PATH:/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/usr/bin/
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/bin


export VIM_BACKGROUND=dark

# PATHs to add.
if [ -f $HOME/.zshrc_paths ]
then
  source $HOME/.zshrc_paths
fi

# C/C++ paths for includes, and library paths.
if [ -e $HOME/.zshrc_devenv ]
then
  source $HOME/.zshrc_devenv
fi

# Oh my zsh.
if [ -f $ZSH/oh-my-zsh.sh ]
then
    source $ZSH/oh-my-zsh.sh
fi

# Aliases.
if [ -f $HOME/.zshrc_aliases ]
then
  source $HOME/.zshrc_aliases
fi

# Local conf.
if [ -f $HOME/.zshrc_local ]
then
  source $HOME/.zshrc_local
fi
