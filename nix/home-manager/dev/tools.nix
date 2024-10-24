{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    # Nix formatter
    alejandra

    # Formatters
    nodePackages.prettier # JavaScript et al. formatter
    prettierd # JavaScript et al. formatter as daemon
    ruff # Python linter and formatter
    stylua # Lua formatter
    buf # Proto formatter
    google-java-format # Java formatter
    beautysh # Shell scripts formatter
    ktlint # Kotlin formatter
    taplo # TOML formatter
    typstyle # Typst formatter
    yamlfix # YAML formatter
    ocamlPackages.ocamlformat # Ocaml formatter
    uncrustify # C, C++, C#, ObjectiveC, D, Java, Pawn and VALA formatter
    elmPackages.elm-format # Eml formatter

    pyright # python LSP

    dafny # A programming language with built-in specification constructs

    typos # Source code type checker

    alloy6 # Language & tool for relational models

    tinymist # Better typst LSP

    gofumpt # Stricter go formatter
  ];

  programs.lazygit.enable = true;
}
