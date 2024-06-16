# modules/programs.nix
#
# Author: Diogo Correia <me@diogotc.com>
# URL:    https://github.com/diogotcorreia/dotfiles
#
# global programs and packages
{
  pkgs,
  config,
  lib,
  ...
}: {
  # Essential packages
  environment.systemPackages = with pkgs; [
    # Compressed archives
    atool
    zip
    unzip

    # Nix formatter
    alejandra

    # System monitor
    htop
    procps
    gdu
    duf

    # Neofetch
    neofetch

    # Man pages
    man-pages

    # Find and search files
    fzf
    ripgrep
  ];
}
