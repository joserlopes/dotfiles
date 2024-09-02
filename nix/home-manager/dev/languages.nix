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
        ]
    ))
    # Lua
    lua
    # Zig
    unstable.zig
    # Elixir
    elixir
  ];

  # Golang
  programs.go.enable = true;

  # Ocaml
  programs.opam.enable = true;

  # Bun
  programs.bun = {
    enable = true;
    package = pkgs.unstable.bun;
  };
}
