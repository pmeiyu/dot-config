self: super:

{
  command-line-packages = super.pkgs.buildEnv {
    name = "command-line-packages";
    paths = with super.pkgs; [
      aria2
      badvpn
      graphviz
      msmtp
      mu
      ncmpcpp
      offlineimap
      p7zip
      rclone
      youtube-dl
    ];
  };

  hardware-packages = super.pkgs.buildEnv {
    name = "hardware-packages";
    paths = with super.pkgs; [
      dmidecode
      lm_sensors
      powertop
      smartmontools
    ];
  };

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

  office-packages = super.pkgs.buildEnv {
    name = "office-packages";
    paths = with super.pkgs; [
      gimp
      libreoffice
      obs-studio
      opencc
      pandoc
    ];
  };
}
