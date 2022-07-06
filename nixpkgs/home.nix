{ config, lib, pkgs, ... }:

{
  home.stateVersion = "22.05";
  news.display = "silent";

  home.username = "meiyu";
  home.homeDirectory = "/home/meiyu";

  home.packages = with pkgs; [
    local-packages
    command-line-packages
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
    profiles = {
      "default.profile" = {
        id = 0;
        settings = {
          "browser.aboutConfig.showWarning" = false;
          "browser.tabs.closeWindowWithLastTab" = false;
          "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "signon.rememberSignons" = false;
          "ui.key.menuAccessKeyFocuses" = false;

          "network.captive-portal-service.enabled" = false;
        };
      };
    };
  };
}
