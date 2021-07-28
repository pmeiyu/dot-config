self: super:

{
  programming-packages-all = super.pkgs.buildEnv {
    name = "programming-packages-all";
    paths = with super.pkgs; [
      programming-packages-tools
      programming-packages-bash
      programming-packages-c
      programming-packages-go
      programming-packages-java
      programming-packages-nodejs
      programming-packages-python
      programming-packages-rust
      programming-packages-web
    ];
  };

  programming-packages-tools = super.pkgs.buildEnv {
    name = "programming-packages-tools";
    paths = with super.pkgs; [
      gettext
      gitFull
      gnumake
    ];
  };

  programming-packages-bash = super.pkgs.buildEnv {
    name = "programming-packages-bash";
    paths = with super.pkgs; [
      nodePackages.bash-language-server
      shellcheck
    ];
  };

  programming-packages-c = super.pkgs.buildEnv {
    name = "programming-packages-c";
    paths = with super.pkgs; [
      clang-tools
      gcc
    ];
  };

  programming-packages-go = super.pkgs.buildEnv {
    name = "programming-packages-go";
    paths = with super.pkgs; [
      go
      gopls
    ];
  };

  programming-packages-java = super.pkgs.buildEnv {
    name = "programming-packages-java";
    paths = with super.pkgs; [
      gradle
      jdk
      maven
      visualvm
    ];
  };

  programming-packages-nodejs = super.pkgs.buildEnv {
    name = "programming-packages-nodejs";
    paths = with super.pkgs; [
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodejs
      yarn
    ];
  };

  my-python = super.python3.withPackages (python-packages:
    with python-packages; [
      beautifulsoup4
      ipython
      matplotlib
      numpy
      pandas
      peewee
      pillow
      pip
      ptpython
      python-lsp-server
      pytz
      requests
      sqlalchemy
    ]);

  programming-packages-python = super.pkgs.buildEnv {
    name = "programming-packages-python";
    paths = with super.pkgs; [
      my-python
    ];
  };

  programming-packages-rust = super.pkgs.buildEnv {
    name = "programming-packages-rust";
    paths = with super.pkgs; [
      cargo
      rls
      rustc
      rustfmt
      # rustup
    ];
  };

  programming-packages-web = super.pkgs.buildEnv {
    name = "programming-packages-web";
    paths = with super.pkgs; [
      nodePackages.vscode-css-languageserver-bin
      nodePackages.vscode-html-languageserver-bin
      nodePackages.vue-language-server
    ];
  };
}
