{ pkgs, ... }:

{
  home.packages = with pkgs; [
    local-packages
    command-line-packages
    latex-packages
    office-packages
    programming-packages-tools
    programming-packages-python
  ];
}
