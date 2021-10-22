self: super:

{
  nixpkgs-master = import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/master.tar.gz") { };
}
