#!/usr/bin/env bash

# ls
alias ls='ls --color=auto -F'
alias ll='ls -lhF'
alias lll='ls -lahF'
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
    column -ts ',' "$1" | less -S;
}

coltsv () {
    column -ts $'\t' "$1" | less -S;
}
