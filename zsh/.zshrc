#+TITLE: Zsh Configuration
#+AUTHOR: Peng Mei Yu


# ==============================
# Environment Variables
# ==============================

# Zsh configuration location
ZSH_HOME=${ZDOTDIR:-$HOME}


# ==============================
# Aliases
# ==============================

alias e=$EDITOR
alias ec=emacsclient
alias se=sudoedit

alias df="command df -h"
alias du="command du -h"
alias open="command xdg-open"
alias py="command ptipython"
alias rsync='command rsync -hrtP --filter ". $XDG_CONFIG_HOME/rsync/filter"'

alias gpg-update-tty="gpg-connect-agent updatestartuptty /bye"
alias ssh-socks="ssh -o ProxyCommand='ncat --proxy-type socks5 --proxy localhost:1080 %h %p'"


# ==============================
# Load local configurations
# ==============================

if [[ -f $ZSH_HOME/local-zshrc.sh ]]; then
    source $ZSH_HOME/local-zshrc.sh
fi
