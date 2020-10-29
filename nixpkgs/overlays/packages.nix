self: super:

{
  emacs-git = (super.emacs.override { srcRepo = true; }).overrideAttrs
    (attrs: rec {
      name = "emacs-${version}${versionModifier}";
      version = "0.0.0";
      versionModifier = "-git";
      src = ~/Projects/emacs;
      patches = [ ];
      doCheck = false;
    });

  ncmpcpp = super.ncmpcpp.override {
    visualizerSupport = true;
    fftw = super.fftw;
  };
}
