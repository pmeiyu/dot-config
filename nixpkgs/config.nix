with (import <nixpkgs> { }); {
  # allowBroken = true;
  # allowUnfree = true;

  packageOverrides = pkgs: {
    my-packages = pkgs.buildEnv {
      name = "my-packages";
      paths = with pkgs; [
        local-packages
        command-line-packages
        latex-packages
        office-packages
        programming-packages-tools
        programming-packages-python
      ];
    };
    local-packages = pkgs.buildEnv {
      name = "local-packages";
      paths = with pkgs; [ ];
    };
  };
}
