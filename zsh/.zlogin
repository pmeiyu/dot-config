#+TITLE: Zsh Configuration
#+AUTHOR: Peng Mei Yu


# ==============================
# Shepherd
# ==============================

if [[ -d ${XDG_RUNTIME_DIR-/run/user/$(id -u)} &&
          ! -S ${XDG_RUNTIME_DIR-/run/user/$(id -u)}/shepherd/socket ]]; then
    command -v shepherd >/dev/null && shepherd
fi


# ==============================
# Tmux
# ==============================

# Automatically start tmux on interactive SSH shell.
if [[ -t 0 && -n $SSH_CONNECTION && -z $TMUX ]] && command -v tmux >/dev/null;
then
    # If no tmux session is started, start a new session.
    if tmux has-session; then
        exec tmux attach
    else
        exec tmux new-session
    fi
fi
