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
  ];

  programs.lazygit.enable = true;
}
