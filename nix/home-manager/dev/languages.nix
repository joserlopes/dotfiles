{pkgs, ...}: {
  home.packages = with pkgs; [
    neofetch
    # typst
    unstable.typst
    # Python
    (pkgs.python3.withPackages (
      p:
        with p; [
          esprima
          tox
          virtualenv
          ipython
          jupyter
          python-sat
          pypblib
          z3-solver
          playsound
          requests
          pwntools
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
    nodejs_23

    # Java VM
    jdk

    # Rust
    rustup
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
