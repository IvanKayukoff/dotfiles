# NodeJS config
export PATH=$PATH:/opt/node-v10.13.0-linux-x64/bin

# Go config
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/code/go-toying
export PATH=$PATH:$(go env GOPATH)/bin

# Aliases
alias gs="git status"
alias ga="git add"
alias gl="git log"
alias gd="git diff"
alias gr="git reset"
alias gds="git diff --staged"
alias gc="git commit"
alias gpm="git push origin master"

bindkey -v
export KEYTIMEOUT=1 # remove the delay after hitting ESC

function texwatch {
  while ! inotifywait -e close_write $1; do
    xelatex -output-directory=`pwd`/out/ $1
  done
}

export ZSH=/home/sky/.oh-my-zsh
ZSH_THEME="rkj"

source $ZSH/oh-my-zsh.sh

