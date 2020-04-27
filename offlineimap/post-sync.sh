#!/bin/sh

# Update mu index.
#
# `mu index` will fail if mu4e is opened in Emacs.  So try updating index from
# Emacs instead.
if pgrep -f "mu server" >/dev/null; then
    emacsclient -e "(mu4e-update-index)"
else
    mu index
fi


# Notify new email
count=$(mu find 'flag:unread and maildir:/INBOX' | grep -E --count '.+')
if test "$count" -ne 0; then
    notify-send Email "$count unread email"
fi
