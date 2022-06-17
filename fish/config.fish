#+TITLE: Fish Shell Configuration
#+AUTHOR: Peng Mei Yu


# ==============================
# Fish Shell Theme
# ==============================

if status is-interactive
    set -g theme_color_scheme dark
    set -g theme_date_format "+%H:%M:%S"
    set -g theme_powerline_fonts no
end

# Disable fish greeting message
function fish_greeting
end


# ==============================
# Environment Variables
# ==============================

# XDG
if status is-login
    test "$XDG_CONFIG_HOME" = "" && set -gx XDG_CONFIG_HOME $HOME/.config
    test "$XDG_DATA_HOME" = "" && set -gx XDG_DATA_HOME $HOME/.local/share
    test "$XDG_CACHE_HOME" = "" && set -gx XDG_CACHE_HOME $HOME/.cache
end

# Path
if status is-login || status is-interactive
    function add_path --description "add directory to PATH variable"
        # trim trailing slash
        set --local dir (string replace -r '(.+)/$' '$1' $argv[1])
        if ! contains $dir $fish_user_paths && test -d $dir
            set fish_user_paths $dir $fish_user_paths
        end
    end

    function remove_path  --description "remove directory from PATH variable"
        # trim trailing slash
        set --local dir (string replace -r '(.+)/$' '$1' $argv[1])
        if set --local index (contains -i $dir $fish_user_paths); \
            or set --local index (contains -i "$dir/" $fish_user_paths)
            set --erase --universal fish_user_paths[$index]
        else if set --local index (contains -i $dir $PATH); \
            or set --local index (contains -i "$dir/" $PATH)
            set --erase PATH[$index]
        end
    end

    if status is-login
        if not set -q fish_user_paths
            set -U fish_user_paths
        end

        add_path $HOME/.local/bin
    end
end

# CDPATH
if status is-login
    set -gx CDPATH . "$HOME/"
end

# Editor
if status is-login
    if command -qs "emacsclient"
        set -gx EDITOR "emacsclient -t"
        set -gx VISUAL "emacsclient"
    else if command -qs "zile"
        set -gx EDITOR "zile"
        set -gx VISUAL "zile"
    end

    set -gx SUDO_EDITOR $EDITOR
end

# Guile
if status is-login
    set -gx GUILE_HISTORY "$XDG_DATA_HOME/guile/history"
    set -gx GUILE_WARN_DEPRECATED detailed
end


# ==============================
# Aliases
# ==============================

# Editor
if status is-interactive
    alias e=$EDITOR
    alias ec=emacsclient
    alias se="sudoedit"
end

if status is-interactive
    alias df "command df -h"
    alias du "command du -h"
    alias ffmpeg "command ffmpeg -hide_banner"
    alias ffprobe "command ffprobe -hide_banner"
    alias py "command ptipython"
    alias rsync 'command rsync -hrtP --filter ". $XDG_CONFIG_HOME/rsync/filter"'

    # One-line utilities
    alias gpg-update-tty "gpg-connect-agent updatestartuptty /bye"
    alias ssh-socks "ssh -o ProxyCommand='ncat --proxy-type socks5 --proxy localhost:1080 %h %p'"
end


# ==============================
# Guix
# ==============================

if status is-login
    set MY_PROFILE "$HOME/.guix-profile"
    set ROOT_PROFILE "/var/guix/profiles/per-user/root/guix-profile"

    # Guix on foreign operating systems.
    if test -d /gnu && ! test -L /run/current-system/profile
        # Environment
        set -gx GUIX_LOCPATH "$ROOT_PROFILE/lib/locale"

        # XDG
        test "$XDG_CONFIG_DIRS" = "" && set -gx XDG_CONFIG_DIRS "/etc/xdg"
        test "$XDG_DATA_DIRS" = "" && set -gx XDG_DATA_DIRS "/usr/local/share:/usr/share"
        set -gx XDG_CONFIG_DIRS "$MY_PROFILE/etc/xdg:$XDG_CONFIG_DIRS"
        set -gx XDG_DATA_DIRS "$MY_PROFILE/share:$XDG_DATA_DIRS"

        # Source my etc/profile
        if functions -q fenv && test -f $MY_PROFILE/etc/profile
            set -gx GUIX_PROFILE $MY_PROFILE
            fenv source $MY_PROFILE/etc/profile
            set -e GUIX_PROFILE
        end

        # $PATH
        add_path $MY_PROFILE/sbin
        add_path $MY_PROFILE/bin
        add_path $XDG_CONFIG_HOME/guix/current/bin
    end
end


# ==============================
# Nix
# ==============================

if status is-login
    # Nix on foreign operating systems.
    if test -d /nix && ! test -L /run/current-system/sw
        set PROFILES /run/current-system/profile $HOME/.nix-profile
        for i in $PROFILES
            if functions -q fenv && test -f $i/etc/profile.d/nix.sh
                fenv source $i/etc/profile.d/nix.sh
                break
            end
        end

        # Home Manager
        if functions -q fenv && test -f $i/etc/profile.d/hm-session-vars.sh
            fenv source $i/etc/profile.d/hm-session-vars.sh
        end
    end
end


# ==============================
# Applications
# ==============================

if status is-login
    # SSH
    test -n $SSH_AUTH_SOCK || set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh

    # Python
    set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py

    # Go language
    set -gx GOPATH $HOME/Projects/go
    add_path $GOPATH/bin

    # Jupyter
    set -gx JUPYTER_CONFIG_DIR $XDG_CONFIG_HOME/jupyter

    # disable less history
    set -gx LESSHISTFILE "-"
end

# Input method
if status is-login
    set -gx GTK_IM_MODULE "ibus"
    set -gx QT_IM_MODULE "ibus"
    set -gx XMODIFIERS "@im=ibus"

    # Guix
    if test -L /run/current-system/profile
        set -gx GUIX_GTK2_IM_MODULE_FILE /run/current-system/profile/lib/gtk-2.0/2.10.0/immodules-gtk2.cache
        set -gx GUIX_GTK3_IM_MODULE_FILE /run/current-system/profile/lib/gtk-3.0/3.0.0/immodules-gtk3.cache
    end
end


# ==============================
# Fish Package Manager
# ==============================

if status is-interactive
    function _install_fisher --description "Install fish shell package manager"
        test "$XDG_CONFIG_HOME" = "" && set -l XDG_CONFIG_HOME $HOME/.config
        mkdir -p $XDG_CONFIG_HOME/fish/functions
        set -l url https://git.io/fisher
        set -l destination $XDG_CONFIG_HOME/fish/functions/fisher.fish
        if command -qs "curl"
            curl $url -Lso $destination
        else if command -qs "wget"
            wget $url -qO $destination
        else
            echo "Error: Curl or wget is required to install fisher."
            return
        end

        fish -c fisher
    end

    if not functions -q fisher
        _install_fisher
    end
end


# ==============================
# Local Configurations
# ==============================

if test -f "$XDG_CONFIG_HOME/fish/local.fish"
    source "$XDG_CONFIG_HOME/fish/local.fish"
end
