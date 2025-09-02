# .bashrc

set -h

# Source aliases
if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
fi


# Source extra
if [ -f $HOME/.bashrc_extra ]; then
    . $HOME/.bashrc_extra
fi

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
