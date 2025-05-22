#!/usr/bin/env bash

# ls
alias ls='ls --color=auto'
alias l='ls -lhF'
alias ll='ls -lahF'
alias ññ='echo "did you mean ll? :p"; echo ""; ll'
alias ææ='echo "did you mean ll? :p"; echo ""; ll'

# git
alias gs="git status"
alias gpl="git pull"
alias gps="git push"
alias ga="git add"
alias gaa="git add --all && echo "" && git status"

gc () {
    git commit -m "$1" && echo "" && git status
}

# rust
alias crun="cargo run"
alias clippy="cargo clippy -- -W clippy::pedantic"
alias rust_repl="evcxr"

# misc
alias less="less -S"
alias vi="vim"
alias upd="sudo apt update && sudo apt upgrade -y"
alias rbt="sudo reboot"

# recursive search
rs () {
    grep -rn "$1" *;
}

# column-sep files
colcsv () {
    if [ $# -eq 0 ]; then
        column -ts ',' | less -S;
    else
        column -ts ',' "$1" | less -S;
    fi
}

coltsv () {
    if [ $# -eq 0 ]; then
        column -ts $'\t' | less -S;
    else
        column -ts $'\t' "$1" | less -S;
    fi
}
