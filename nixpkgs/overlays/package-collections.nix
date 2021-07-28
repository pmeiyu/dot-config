self: super:

{
  command-line-packages = super.pkgs.buildEnv {
    name = "command-line-packages";
    paths = with super.pkgs; [
      aria2
      fdm
      graphviz
      jq
      msmtp
      mu
      rclone
      xmlstarlet
      yq
    ];
  };

  hardware-packages = super.pkgs.buildEnv {
    name = "hardware-packages";
    paths = with super.pkgs; [
      dmidecode
      lm_sensors
      nvme-cli
      pciutils
      powertop
      smartmontools
      usbutils
    ];
  };

  multimedia-packages = super.pkgs.buildEnv {
    name = "multimedia-packages";
    paths = with super.pkgs; [
      beets
      exiftool
      ffmpeg
      handbrake
      imagemagick7
      mkvtoolnix
      mpc_cli
      mpd
      mpv
      ncmpcpp
      picard
      vlc
      you-get
      youtube-dl
    ];
  };

  network-packages = super.pkgs.buildEnv {
    name = "network-packages";
    paths = with super.pkgs; [
      curl
      dnsutils
      httpie
      mitmproxy
      nethogs
      ngrep
      nmap
      socat
      tcpdump
      wireshark
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
      unoconv
    ];
  };
}
