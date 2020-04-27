self: super:

{
  office-packages = super.pkgs.buildEnv {
    name = "office-packages";
    paths = with super.pkgs; [
      libreoffice
      obs-studio
    ];
  };
}
