#+TITLE: Zsh Configuration
#+AUTHOR: Peng Mei Yu


# ==============================
# Shepherd
# ==============================

if [[ -d ${XDG_RUNTIME_DIR-/run/user/$(id -u)} &&
          ! -S ${XDG_RUNTIME_DIR-/run/user/$(id -u)}/shepherd/socket ]]; then
    command -v shepherd >/dev/null && shepherd
fi
