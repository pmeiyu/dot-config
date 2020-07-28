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
}
