self: super:

{
  emacs-git = (super.pkgs.emacs.override { srcRepo = true; }).overrideAttrs
    (attrs: rec {
      name = "emacs-${version}${versionModifier}";
      version = "0.0.0";
      versionModifier = "-git";

      doCheck = false;

      src = ~/Projects/emacs;

      patches = [ ];
    });
}
