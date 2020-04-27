# Automatically start tmux on interactive SSH shell.
if status is-login; and status is-interactive; and test -t 0; \
    and test -n "$SSH_CONNECTION"; and test -z "$TMUX";  and command -sq tmux
    # If no tmux session is started, start a new session
    if tmux has-session
        exec tmux attach
    else
        exec tmux new-session
    end
end
