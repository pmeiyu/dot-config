self: super:

let
  overlay = import (builtins.fetchTarball {
    url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
  });
  pkgs = overlay self super;
in
{
  emacsGit = pkgs.emacsGit;
  emacsGit-nox = pkgs.emacsGit-nox;
  emacsPgtk = pkgs.emacsPgtk;
  emacsUnstable = pkgs.emacsUnstable;
  emacsUnstable-nox = pkgs.emacsUnstable-nox;
}
