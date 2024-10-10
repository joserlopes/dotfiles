{pkgs, ...}: {
  home.packages = with pkgs; [
    neofetch
    # typst
    unstable.typst
    # Python
    (pkgs.python3.withPackages (
      p:
        with p; [
          tox
          virtualenv
          ipython
          jupyter
          python-sat
          pypblib
          z3-solver
        ]
    ))
    # Lua
    lua
    # Zig
    unstable.zig
    # Elixir
    elixir

    # Elm
    elmPackages.elm

    # Node
    nodejs_22

    # Java VM
    jdk
  ];

  # Golang
  programs.go = {
    enable = true;
    package = pkgs.unstable.go;
  };

  # Ocaml
  programs.opam = {
    enable = true;
    package = pkgs.unstable.opam;
  };

  # Bun
  programs.bun = {
    enable = true;
    package = pkgs.unstable.bun;
  };
}
