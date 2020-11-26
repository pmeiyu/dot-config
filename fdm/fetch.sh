#!/bin/sh

# Fetch email.
fdm fetch

# Update mu index.
#
# `mu index` will fail if mu4e is opened in Emacs.  So try updating index from
# Emacs instead.
if pgrep -f "mu server" >/dev/null; then
    emacsclient -e "(mu4e-update-index)"
else
    mu index
fi

# Notification.
count=$(mu find 'flag:unread and maildir:/inbox' | grep -E --count '.+')
if test "$count" -ne 0; then
    notify-send Email "$count unread email"
fi
