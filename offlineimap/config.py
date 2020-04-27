import os
import subprocess


def emacs_get_secret(domain, user):
    cmd = "emacsclient -e '(my-get-secret :domain \"{}\" :user \"{}\")'".format(domain, user)
    try:
        secret = subprocess.check_output(cmd, shell=True).strip()
    except:
        return
    if secret == "nil":
        return
    else:
        # strip double quotes
        return secret[1:-1]


def keychain_get_secret(domain, user):
    cmd = "secret-tool lookup domain '{}' user '{}'".format(domain, user)
    try:
        password = subprocess.check_output(cmd, shell=True).strip()
    except:
        return
    return password
