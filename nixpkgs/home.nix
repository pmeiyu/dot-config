{ config, lib, pkgs, ... }:

{
  home.stateVersion = "21.11";
  news.display = "silent";

  home.username = "meiyu";
  home.homeDirectory = "/home/meiyu";

  home.packages = with pkgs; [
    local-packages
    command-line-packages
    multimedia-packages
    network-packages
    office-packages
    programming-packages-tools
    programming-packages-python
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
    profiles = {
      default = {
        id = 0;
        settings = {
          "browser.aboutConfig.showWarning" = false;
          "browser.tabs.closeWindowWithLastTab" = false;
          "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "signon.rememberSignons" = false;
          "ui.key.menuAccessKeyFocuses" = false;
        };
      };
    };
  };
}
