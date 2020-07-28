self: super:

{
  emacs-git = (super.emacs.override { srcRepo = true; }).overrideAttrs
    (attrs: rec {
      name = "emacs-${version}${versionModifier}";
      version = "0.0.0";
      versionModifier = "-git";

      src = ~/Projects/emacs;

      patches = [ ];

      buildInputs = attrs.buildInputs ++ [ super.jansson super.harfbuzz.dev ];

      doCheck = false;
    });
}
