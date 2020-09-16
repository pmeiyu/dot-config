self: super:

{
  local-packages = super.pkgs.buildEnv {
    name = "local-packages";
    paths = with super.pkgs; [ ];
  };
}
