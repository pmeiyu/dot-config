#+TITLE: Zsh Configuration
#+AUTHOR: Peng Mei Yu


# ==============================
# Environment Variables
# ==============================

# Load system-wide environment variables
[[ -f /etc/profile ]] && source /etc/profile

# Zsh configuration location
ZSH_HOME=${ZDOTDIR:-$HOME}

# XDG
[[ -z $XDG_CONFIG_HOME ]] && export XDG_CONFIG_HOME=$HOME/.config
[[ -z $XDG_DATA_HOME ]] && export XDG_DATA_HOME=$HOME/.local/share
[[ -z $XDG_CACHE_HOME ]] && export XDG_CACHE_HOME=$HOME/.cache

# PATH
export PATH=$HOME/.local/bin:$PATH

# CDPATH
export CDPATH=".:$HOME"

# Editor
if command -v "emacsclient" >/dev/null; then
    export EDITOR="emacsclient -t"
    export VISUAL="emacsclient"
elif command -v "zile" >/dev/null; then
    export EDITOR="zile"
    export VISUAL="zile"
fi
export SUDO_EDITOR=$EDITOR

# Guile
export GUILE_HISTORY=$XDG_DATA_HOME/guile/history
export GUILE_WARN_DEPRECATED=detailed


# ==============================
# Guix
# ==============================

MY_PROFILE=$HOME/.guix-profile
ROOT_PROFILE="/var/guix/profiles/per-user/root/guix-profile"

# Guix on foreign operating systems.
if [[ -d /var/guix && ! -L /run/current-system/profile ]]; then
    # Environment
    export GUIX_LOCPATH=$ROOT_PROFILE/lib/locale

    # XDG
    [[ -z $XDG_CONFIG_DIRS ]] && export XDG_CONFIG_DIRS="/etc/xdg"
    [[ -z $XDG_DATA_DIRS ]] && export XDG_DATA_DIRS="/usr/local/share:/usr/share"
    export XDG_CONFIG_DIRS=$MY_PROFILE/etc/xdg:$XDG_CONFIG_DIRS
    export XDG_DATA_DIRS=$MY_PROFILE/share:$XDG_DATA_DIRS

    # Load $MY_PROFILE/etc/profile
    GUIX_PROFILE=$MY_PROFILE; source $GUIX_PROFILE/etc/profile

    # PATH
    export PATH=$XDG_CONFIG_HOME/guix/current/bin:$PATH
fi


# ==============================
# Nix
# ==============================

# Nix on foreign operating systems.
PROFILES="/run/current-system/profile $HOME/.nix-profile"
for i in $(echo $PROFILES); do
    if [[ -f "$i/etc/profile.d/nix.sh" ]]; then
        source "$i/etc/profile.d/nix.sh"
        break
    fi
done


# ==============================
# Applications
# ==============================

# Python
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/startup.py

# Go language
export GOPATH=$HOME/Projects/go
export PATH=$GOPATH/bin:$PATH

# Jupyter
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter

# Disable `less` history file
export LESSHISTFILE="-"

# Input method
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="ibus"
export XMODIFIERS="@im=ibus"

# Input method configuration for Guix
if [[ -L /run/current-system/profile ]]; then
    export GUIX_GTK2_IM_MODULE_FILE=/run/current-system/profile/lib/gtk-2.0/2.10.0/immodules-gtk2.cache
    export GUIX_GTK3_IM_MODULE_FILE=/run/current-system/profile/lib/gtk-3.0/3.0.0/immodules-gtk3.cache
fi


# ==============================
# Load local configurations
# ==============================

if [[ -f $ZSH_HOME/local-profile.sh ]]; then
    source $ZSH_HOME/local-profile.sh
fi
