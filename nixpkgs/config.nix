with (import <nixpkgs> { }); {
  # allowBroken = true;
  # allowUnfree = true;

  packageOverrides = pkgs: {
    my-packages = pkgs.buildEnv {
      name = "my-packages";
      paths = with pkgs; [
        local-packages
        latex-packages
        office-packages
        programming-packages
        python-programming-packages
      ];
    };
  };
}
