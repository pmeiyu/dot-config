self: super:

{
  office-packages = super.pkgs.buildEnv {
    name = "office-packages";
    paths = with super.pkgs; [
      gimp
      libreoffice
      obs-studio
      opencc
    ];
  };
}
