# Fonts config
{pkgs, ...}: {
  home.packages = with pkgs; [
    fira-code
    nerdfonts
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
    noto-fonts-cjk-sans
  ];

  # Enable managing fonts through home-manager
  fonts.fontconfig.enable = true;
}
