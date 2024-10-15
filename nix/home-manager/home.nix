{
  pkgs,
  configDir,
  ...
}: {
  imports = [
    ./scripts.nix
    ./Urls.nix
    ./dev/languages.nix
    ./dev/tools.nix
    ./shell/tmux.nix
    # ./wallpaper.nix
    ./firefox.nix
    ./graphical/fonts.nix
    ./graphical/gtk.nix
    # ./graphical/i3.nix
    ./graphical/xournalpp.nix
    ./graphical/zathura.nix
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

    # Music player
    amberol

    # Bluetooth
    blueman

    arandr

    variety

    i3
    i3status-rust
    picom
    dunst
    autorandr

    pavucontrol
  ];

  # Clipboard manager
  services.clipmenu.enable = true;

  services.flameshot = {
    enable = true;
    settings = {
      General = {
        disabledTrayIcon = true;
        savePath = "/tmp";
        savePathFixed = false;
        saveAsFileExtension = ".png";
        startupLaunch = false;
        antialiasingPinZoom = true;
        uploadWithoutConfirmation = false;
        predefinedColorPaletteLarge = true;
      };
    };
  };

  # programs.rofi = {
  #   enable = true;
  #   terminal = "${pkgs.alacritty}/bin/alacritty";
  #   theme = "${configDir}/theme.rasi";
  #   extraConfig = {
  #     combi-modi = "URL:URL,drun";
  #     modi = "combi";
  #   };
  # };

  # programs.neovim = {
  # enable = true;
  # package = pkgs.unstable.neovim-unwrapped;
  # };

  xresources.extraConfig = ''
    Xcursor.size: 16
  '';

  programs.home-manager.enable = true;
}
