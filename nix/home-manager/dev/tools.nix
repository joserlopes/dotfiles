{pkgs, ...}: {
  home.packages = with pkgs; [
    # Nix formatter
    alejandra

    # better fzf
    skim
  ];
}
