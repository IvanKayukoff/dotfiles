# Aliases
alias gs="git status"
alias ga="git add"
alias gl="git log"
alias gd="git diff"
alias gr="git reset"
alias gds="git diff --staged"
alias gc="git commit"
alias gp="git push"

bindkey -v
export KEYTIMEOUT=1 # remove the delay after hitting ESC

function texwatch {
  while ! inotifywait -e close_write $1; do
    xelatex -output-directory=`pwd`/out/ $1
  done
}

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk

export ZSH=/home/sky/.oh-my-zsh
ZSH_THEME="robbyrussell"

export PATH="$PATH:/home/sky/.local/bin"

source $ZSH/oh-my-zsh.sh

