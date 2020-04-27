self: super:

{
  my-texlive = super.texlive.combine {
    inherit (super.texlive)
      scheme-small collection-latexextra collection-luatex
      collection-langchinese collection-langjapanese;
  };

  latex-packages = super.pkgs.buildEnv {
    name = "latex-packages";
    paths = with super.pkgs; [
      my-texlive

      # TeX language server
      lua53Packages.digestif
    ];
  };
}
