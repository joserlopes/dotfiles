{pkgs, ...}: {
  imports = [
    ./scripts.nix
    ./Urls.nix
    ./dev/languages.nix
    ./dev/tools.nix
    ./shell/tmux.nix
    ./wallpaper.nix
    ./firefox.nix
    ./graphical/xournalpp.nix
    ./graphical/zathura.nix
    ./graphical/fonts.nix
    ./shell/starship.nix
    ./shell/zsh.nix
    ./shell/git.nix
  ];

  home.username = "jrl";
  home.homeDirectory = "/home/jrl";
  home.stateVersion = "24.05";
  home.packages = with pkgs; [
    neofetch

    feh

    firefox

    obsidian

    # Keyboard remaper
    kanata
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
  };

  programs.home-manager.enable = true;
}
