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

    nixd # Better nix LSP

    dafny # A programming language with built-in specification constructs

    typos # Source code type checker

    alloy6 # Language & tool for relational models

    tinymist # Better typst LSP

    gofumpt # Stricter go formatter

    protobuf # proto compiler

    # TODO: Maybe wait for it this to be integrated into home-manager?
    # ghostty # Better terminal emulator
    neovim-unwrapped
  ];

  programs.lazygit.enable = true;

  programs.zellij = {
    enable = true;
  };
}
