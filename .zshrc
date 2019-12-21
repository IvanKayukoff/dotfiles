# Aliases
alias gs="git status"
alias ga="git add"
alias gd="git diff"
alias gr="git reset"
alias gds="git diff --staged"
alias gc="git commit"
alias gp="git push"
alias go="git checkout"
alias gb="git branch"
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset \
  -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias i3lock="i3lock --color 161616"

bindkey -v
export KEYTIMEOUT=1 # remove the delay after hitting ESC

function texwatch {
  while ! inotifywait -e close_write $1; do
    xelatex -output-directory=`pwd`/out/ $1
  done
}

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="rkj"

export PATH="$PATH:$HOME/.local/bin"

source $ZSH/oh-my-zsh.sh

# remove username@hostname from the prompt (useful for agnoster theme)
prompt_context() {  }

