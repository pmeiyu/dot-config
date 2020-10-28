with (import <nixpkgs> { }); {
  # allowBroken = true;
  # allowUnfree = true;

  packageOverrides = pkgs: {
    local-packages = pkgs.buildEnv {
      name = "local-packages";
      paths = with pkgs; [ ];
    };
  };
}
