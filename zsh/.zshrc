#+TITLE: Zsh Configuration
#+AUTHOR: Peng Mei Yu


# ==============================
# Environment Variables
# ==============================

# Force emacs to enable 24-bit color feature.
export COLORTERM=truecolor


# ==============================
# Aliases
# ==============================

alias e=$EDITOR
alias ec=emacsclient
alias se=sudoedit

alias df="command df -h"
alias du="command du -h"
alias ffmpeg="command ffmpeg -hide_banner"
alias ffprobe="command ffprobe -hide_banner"
alias open="command xdg-open"
alias py="command ptipython"
alias rsync='command rsync -hrtP --filter ". $XDG_CONFIG_HOME/rsync/filter"'

alias gpg-update-tty="gpg-connect-agent updatestartuptty /bye"
alias ssh-socks="ssh -o ProxyCommand='ncat --proxy-type socks5 --proxy localhost:1080 %h %p'"


# ==============================
# Load local configurations
# ==============================

if [[ -f $ZDOTDIR/local-zshrc.sh ]]; then
    source $ZDOTDIR/local-zshrc.sh
fi


# ==============================
# Switch to fish shell
# ==============================

# Switch to fish shell if parent process is a tmux server.
if [[ $(ps -o comm= -p $PPID) == "tmux: server" ]] && command -v fish >/dev/null;
then
    exec fish -i
fi
