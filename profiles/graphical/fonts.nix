{pkgs, ...}: {
  fonts.packages = with pkgs; [
    fira-code
    nerdfonts
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
    noto-fonts-cjk-sans
  ];
}
