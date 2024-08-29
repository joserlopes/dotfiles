{pkgs, ...}: {
  imports = [
    ./dev/languages.nix
    ./dev/tools.nix
    ./shell/tmux.nix
    ./wallpaper.nix
    ./firefox.nix
  ];

  home.username = "jrl";
  home.homeDirectory = "/home/jrl";
  home.stateVersion = "24.05";
  home.packages = with pkgs; [
    neofetch
    feh
    fira-code
    nerdfonts
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
    noto-fonts-cjk-sans
    firefox
  ];
  programs.home-manager.enable = true;
}
