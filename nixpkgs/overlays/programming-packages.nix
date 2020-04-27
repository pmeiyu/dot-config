self: super:

{
  programming-packages = super.pkgs.buildEnv {
    name = "programming-packages";
    paths = with super.pkgs; [
      # Language servers
      nodePackages.bash-language-server

      # Tools
      gettext
      gnumake
    ];
  };

  c-programming-packages = super.pkgs.buildEnv {
    name = "c-programming-packages";
    paths = with super.pkgs; [ clang-tools gcc ];
  };

  go-programming-packages = super.pkgs.buildEnv {
    name = "go-programming-packages";
    paths = with super.pkgs; [ go go-langserver ];
  };

  java-programming-packages = super.pkgs.buildEnv {
    name = "java-programming-packages";
    paths = with super.pkgs; [ gradle maven ];
  };

  nodejs-programming-packages = super.pkgs.buildEnv {
    name = "nodejs-programming-packages";
    paths = with super.pkgs; [
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodejs
      yarn
    ];
  };

  my-python = super.python3.withPackages (python-packages:
    with python-packages; [
      ipython
      matplotlib
      peewee
      pillow
      pip
      ptpython
      pymysql
      python-language-server
      pytz
      requests
      virtualenvwrapper
    ]);

  python-programming-packages = super.pkgs.buildEnv {
    name = "python-programming-packages";
    paths = with super.pkgs; [ my-python ];
  };

  rust-programming-packages = super.pkgs.buildEnv {
    name = "rust-programming-packages";
    paths = with super.pkgs; [
      cargo
      rls
      rustc
      rustfmt
      # rustup
    ];
  };

  web-programming-packages = super.pkgs.buildEnv {
    name = "web-programming-packages";
    paths = with super.pkgs; [
      nodePackages.vscode-css-languageserver-bin
      nodePackages.vscode-html-languageserver-bin
      nodePackages.vue-language-server
    ];
  };

}
