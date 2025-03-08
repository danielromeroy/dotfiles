#!/usr/bin/env bash

# ls
alias ls='ls --color=auto -F'
alias l='ls -CF'
alias ll='ls -lahF'
alias ññ='echo "did you mean ll? :p"; ll'
alias ææ='echo "did you mean ll? :p"; ll'

# git
alias gs="git status"
alias gc="git commit -m"
alias gpl="git pull"
alias gps="git push"
alias ga="git add"
alias gaa="git add *"

# rust
alias crun="cargo run"
alias clippy="cargo clippy -- -W clippy::pedantic"
alias rust="evcxr"

# column-sep files
alias coltsv="column -ts $'\t'"
alias colcsv="column -ts ','"

# misc
alias less="less -S"
alias vi="vim"

rs () {
    grep -rn "$1" *;
}
