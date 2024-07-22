# global programs and packages
{pkgs, ...}: {
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

    # Fastfetch
    fastfetch

    # Man pages
    man-pages

    # Find and search files
    fzf
    ripgrep

    # Password Manager
    keepassxc

    # Dropbox
    dropbox

    wget
    curl
    gcc
    wl-clipboard
    xclip
    feh

    # Static site generator
    zola
  ];
}
